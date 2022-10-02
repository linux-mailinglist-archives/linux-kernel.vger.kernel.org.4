Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26725F256D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJBVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJBVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:16:22 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75E33369;
        Sun,  2 Oct 2022 14:16:21 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c24so8146145plo.3;
        Sun, 02 Oct 2022 14:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7PRALPtNnNjBmMltxI0wfcAZlP8MoKB6zfYDILX4ez0=;
        b=MWT2TAUkp9tE3UCElPWkPPG5BUs6u2MvEUp8aslfq6RzbGra4nEDR73H4achyReFuO
         /MNgFPyzJPGlxmgNxVucbVGr1WTYZJ/Zex85OVFy+T0xc/K5XTd1YAdoTaQHZSLM0W8s
         oX6gjIEXPV/sJPW3WdjlTJJpWkqd+pE3Wt1P32Abz6EjrpjkNvYvcUNQQanY6SlhcsjB
         XxlILuy+8rLDQ8XXWoYcwtmOe7s4+5DAwfUc7NpLCHEqDQBlkrlZxDKqgYGylJzUyKWi
         nF6tKFlIVYLCAvXUXDnXYeAgMtqQ8/MK8AX46aB6KikOHEDXfaqjHMHRvTDLcZNMKlc7
         ndtw==
X-Gm-Message-State: ACrzQf1ITC1TdhXhYT+JT9Uz8Q3jzcJ0s6Rj48Bgjmhqwp2AILyfFypC
        ibOnVDkRYB1XJvU47/ytw6I=
X-Google-Smtp-Source: AMsMyM4beUiY//4c8PiR4l3QuNLl8/NIDgpZGXOq3Kqhvxdk6CeEGethftuj/XdxFxW1GrzgBsvbdQ==
X-Received: by 2002:a17:902:b718:b0:17a:d64:de09 with SMTP id d24-20020a170902b71800b0017a0d64de09mr19380482pls.106.1664745381086;
        Sun, 02 Oct 2022 14:16:21 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ac08300b0020a73eec389sm2891587pjs.3.2022.10.02.14.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 14:16:20 -0700 (PDT)
Message-ID: <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
Date:   Sun, 2 Oct 2022 14:16:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220928181350.9948-1-leeman.duncan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 11:13, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
> (front end) do not like the recent commit:
> 
> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> 
> That commit changed getting SCSI VPD pages so that we now read
> just enough of the page to get the actual page size, then read
> the whole page in a second read. The problem is that the above
> mentioned hardware returns zero for the page size, because of
> a firmware error. In such cases, until the firmware is fixed,
> this new black flag says to revert to the original method of
> reading the VPD pages, i.e. try to read as a whole buffer's
> worth on the first try.
> 
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")

Hi Lee,

If we introduce a blacklist flag to skip querying the VPD page size then 
we will have to find all SCSI devices that do not handle querying the 
VPD page size correctly. Has it been considered instead of introducing a 
blacklist flag to not use the reported VPD page size if the device 
reports that the VPD page size is zero? I am not aware of any VPD pages 
for which zero is a valid size.

Thanks,

Bart.
