Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C966BB8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjCOQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjCOQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:02:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8425C9F2;
        Wed, 15 Mar 2023 09:01:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p20so20511679plw.13;
        Wed, 15 Mar 2023 09:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQVN31/ZG7/x+XeNc2ngdIjnDeQwy3X1IRCFB33ra+w=;
        b=vffpE8Q57w021u6c+aM3oakf/JxZXGrp+xApTsfOxWuCVAZ7S3G/kwQEftS8b+dj7F
         N9eNj3JOmVE6pE2t1gl0/rKRTa5nyA+k+OdhJMhugOBfvikXRH8fowOKzBZRw0DQl8Q2
         R6F0SBKZ84O2I1YOT+QMUC5459bf3TD5W0/SN/ymNh9nAqleQQoLlRRi3I0xvWq2mR49
         /1i4stTz//u5SxlmziW5Ec55HE7jITU6qNMbMuQcpygEvX3QydiOnHv+WvBuyIanbX8a
         PcRu4gjUfjnKi3KQQDcS5eSQxcLPE1MFjTDUVblRO25WvyhHm/UQR14znxWIoK7xohOO
         dPbQ==
X-Gm-Message-State: AO0yUKVE3ehU9QG/INbwkrD+iyrdzRLByw33GqqZSiU9IfnFRdNqOtvO
        vGV+C0EcOgfkv/UTjoXS/9/cEZRa6Tg=
X-Google-Smtp-Source: AK7set8BdX8Fe8k85n2Z3jqJ1O0mTTMQsVszTLXokxWqJ5N6GP4tZccoi4JKX9xBmWUbSzZSAQIA9Q==
X-Received: by 2002:a17:902:ea05:b0:1a0:6852:16e9 with SMTP id s5-20020a170902ea0500b001a0685216e9mr53645plg.14.1678896045413;
        Wed, 15 Mar 2023 09:00:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:558a:e74:a7b9:2212? ([2620:15c:211:201:558a:e74:a7b9:2212])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b0019cb131b8a5sm3831614plj.32.2023.03.15.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:00:44 -0700 (PDT)
Message-ID: <565ed943-ac29-0bc0-17bf-3feb27fbb8e8@acm.org>
Date:   Wed, 15 Mar 2023 09:00:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 5/5] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Content-Language: en-US
To:     =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?UTF-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>
References: <20230307065448.15279-1-powen.kao@mediatek.com>
 <20230307065448.15279-6-powen.kao@mediatek.com>
 <5d317f56-b1ba-e35a-a558-e462a70a4717@acm.org>
 <15ad91681f8f7981ff0be9702a3026ec6c0239e7.camel@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <15ad91681f8f7981ff0be9702a3026ec6c0239e7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 20:29, Powen Kao (高伯文) wrote:
> We did not implement ESI at hardware level but per queue hw interrupt.
> Without disabling MCQ_CQ_EVENT_STATUS, there will be two interrupts,
> CQES (traditional interrupt) and CQ Tail Entry Push Interrupt (per
> queue hw interrupt), raised on a signle command arrival.
> 
> I wouldn't consider it as a bug, but different interrupt design.

I do not agree with adding the ufshcd_disable_intr() call in the 
MediaTek driver. Please move this call to UFS host controller driver 
core and add a quirk since the behavior described above does not comply 
with the UFSHCI 4.0 standard. See also include/ufs/ufs_quirks.h.

Thanks,

Bart.

