Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026696B2906
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCIPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCIPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:45:59 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA3E4C5B;
        Thu,  9 Mar 2023 07:45:58 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id a2so2432138plm.4;
        Thu, 09 Mar 2023 07:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678376758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biZNX5KZ/hMnGZ5e5usbkfRsd1fpRjUN8x8r4dcxMI0=;
        b=4Vy9T0LYmB2rtcUpAOG2AaIuFrgegeScMLkO8ccyiP9YgS+V2KiVyX2BDTzhIEQEJp
         m8l/Yj518RC5gdn8k36cBg2AecuBraocMR13itdUtN1nPqxkI4v/BeQduZjI7Jj8eamh
         t66hWSFqPjedsoi+MvxU3/Z64Y+JTXBJTi2qz8VFTcJ77ajDvreQZDWGdtmVfuJtsZnC
         VRGWrY1QGh97RHxasSPz6HVCxVm/Sf613YGIkVazrj2aeHTBb8gofN8LXMDR/gLxof6M
         Lkvo3MjZbOvHzQfJyPN4NN+w0URdmRCWtp9uOd2vfl30+3ZdCymmNcmKYk0eDCUM943L
         8ayQ==
X-Gm-Message-State: AO0yUKXrLWwrBgJPmJ20BZMZ1nyUu6ilsE3mhrdS+7kWe2eZuFL7WAmG
        mjfOflHe8K/OXE1IlT2cYuXj0XCAR3M=
X-Google-Smtp-Source: AK7set+xPX0lIUeqjOBJsgMn1+hDVCVKiXFB5AlWnVU0ciJ2KmKKfMm6Y6dXl5EDibkB+IhgTTZ2gg==
X-Received: by 2002:a05:6a20:3d0b:b0:c9:9312:5f1d with SMTP id y11-20020a056a203d0b00b000c993125f1dmr29893458pzi.4.1678376758123;
        Thu, 09 Mar 2023 07:45:58 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id 142-20020a630594000000b004fbe302b3f6sm11203167pgf.74.2023.03.09.07.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 07:45:57 -0800 (PST)
Message-ID: <99f2ea8e-e543-fc14-91d7-0e7e29d2f381@acm.org>
Date:   Thu, 9 Mar 2023 07:45:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
 <67db2c6b-c3b0-c525-e6a9-2b2fe6c6adbb@acm.org>
 <f80fd91b-3a03-5c38-72c0-cd5c3edb33b8@quicinc.com>
 <8a83ec79-be04-ec5c-f3ef-67f64dc55f12@acm.org>
 <f96b1867-142f-7fdc-8123-58fe3bdce844@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f96b1867-142f-7fdc-8123-58fe3bdce844@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 18:44, Ziqi Chen wrote:
> Thanks for you suggestion. But the member hwq->id is an Unsigned 
> integer. if you want to identify SDB mode and MCQ mode,  using "0" is 
> enough, Or how about add string such as below?
> 
> ufshcd_command: MCQ: complete_rsp: 1d84000.ufshc: tag: 14, DB: 0x0, 
> size: 32768, IS: 0, LBA: 5979448,opcode: 0x2a (WRITE_10),group_id: 0x0, 
> hqid: 2

Hi Ziqi,

Since 0 is a valid queue ID using 0 to identify the legacy command 
submission mechanism is ambiguous.

Thanks,

Bart.
