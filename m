Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B35FF4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJNUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJNUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:42:04 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16184E6C;
        Fri, 14 Oct 2022 13:42:03 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id 67so5929018pfz.12;
        Fri, 14 Oct 2022 13:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ga7LxVJNGv4uAqLrSohjcAsauiHQKxDPOhkVZVpYsg=;
        b=HsnGI/7PN4oQ7UiDa/bqnwcs3PQ/3xVbplB7+mnmskMlmSyqjR/mvZ5yUqpD6f62AP
         LJLEd9/5uqGevDUHH/NTYpn3Gzk0fNmtrmR0wK6f83pz7SGEsL0iogztOdnOTn3/iZn2
         iB8AcOb98s5z7nLR5cKhE156DNfLqNwmehdrU+pJM7zgdOcTDn11QL1pDZyn4GlZj/81
         YnJd2UkUFy1/a57eyM8A/jAPSj0t+VCnXk8WdlFJKI2fbyL4NJ7KmDI1MgRlf1ysJOR8
         Gw80LipJ0ISSh+CJ/h8IrZDVKVsPFpstRkjkbu3FayQpUzlrb6+ikzD4kUqqJLMe7rqN
         sxDA==
X-Gm-Message-State: ACrzQf3+/zDdWFRBtmtXOyUHSUhZmQXQ/uvZSzpXAlQ5sw6XF+NyqCx+
        T4W4CIA91K8aT2/Aeb99xh6Gmbp40aE=
X-Google-Smtp-Source: AMsMyM50vL9wvp5+9j+O3b4z8oO7+JOrWw6moqZ+lQIvWjKwrQMEFjnf1G26q/5ITrBySUYFuWY1pg==
X-Received: by 2002:a63:982:0:b0:43b:e67b:988c with SMTP id 124-20020a630982000000b0043be67b988cmr6168454pgj.35.1665780122440;
        Fri, 14 Oct 2022 13:42:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7bd3:5500:b9cd:d90d? ([2620:15c:211:201:7bd3:5500:b9cd:d90d])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0016d4f05eb95sm2115374plf.272.2022.10.14.13.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 13:42:01 -0700 (PDT)
Message-ID: <ffc4250d-7446-40eb-9218-6925f44a69ff@acm.org>
Date:   Fri, 14 Oct 2022 13:41:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010092937.520013-1-beanhuo@iokpp.de>
 <20221010092937.520013-2-beanhuo@iokpp.de>
 <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
 <d06a264c4544a23ccccd016c6797d889db526b64.camel@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d06a264c4544a23ccccd016c6797d889db526b64.camel@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 12:20, Bean Huo wrote:
> I am working on the Advanced RPMB, and trying to seperate normal unit
> descriptor and RPMB unit descriptor, will let you know if it is
> possible. or if you know the solution, please let me know, thanks.

Hi Bean,

How about setting .is_visible member of struct attribute_group in the UFS
driver and letting that callback decide which sysfs attributes are visible
depending on the logical unit type?

Thanks,

Bart.
