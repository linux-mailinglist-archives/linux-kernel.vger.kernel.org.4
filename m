Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231A76090B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 03:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJWB1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 21:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWB1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 21:27:35 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671A1FA;
        Sat, 22 Oct 2022 18:27:33 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id io19so662102plb.8;
        Sat, 22 Oct 2022 18:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxn8/fWqKk5uwYUJmeV2YNZEprvktpSj+qw+5kOjvoM=;
        b=AEOnGHiQSx0ifCur+R8hVbv6EoZmXRzrIOI1YcgnElzDlRe6TbyoNERM531m83nugM
         DamrJiz3oVmcE4vPgMHp3DiKNQff11gK3SMkmSMdl/fOkBhvQfQxvzArKOk1rsd2XCCz
         GVoO7PY0sWQSUo2gPRTicjheyL0Ulud3PWM0njsXFu/ZBPoTURt9rs020UqI0Fz+FBqE
         lnbabjJXXu4zr6teBU/58+sBnAEqdthx/lNxJw2cy8zr4n7cZR/GOYQTkALr7C/cm2ry
         zSfbYWLAbcxGEbp33zAmA9d/hN7CqD3ThH64EEJYzIM69T0HxI0/uM7CP9LFTxlvlDXY
         gvsA==
X-Gm-Message-State: ACrzQf3RPNKTRVJ1AA6zSrLEuVuelWzc/Oz+9plThJ9DPiut49aHuu/Y
        iKMOt2EJmQy7kwKBDhnqepI=
X-Google-Smtp-Source: AMsMyM6MSB9NjdfgmovwHqQUK96cfTfpitw7tk0jtz+QWDu6K7xgPFAtY6xG/ZCfPr6Q6f+esTP33g==
X-Received: by 2002:a17:902:8544:b0:183:baae:cf8d with SMTP id d4-20020a170902854400b00183baaecf8dmr27148429plo.96.1666488451973;
        Sat, 22 Oct 2022 18:27:31 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0017f7628cbddsm17072020plb.30.2022.10.22.18.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 18:27:31 -0700 (PDT)
Message-ID: <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
Date:   Sat, 22 Oct 2022 18:27:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
To:     Salvatore Bonaccorso <carnil@debian.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, adi@kriegisch.at,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
Content-Language: en-US
In-Reply-To: <Y1JkuKTjVYrOWbvm@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 02:22, Salvatore Bonaccorso wrote:
> We got the following report in Debian after an update from 5.10.140 to
> the current 5.10.149. Full quoting below (from
> https://bugs.debian.org/1022126). Does this ring some bell about known
> regressions?

Only three mpt3sas changes are new in v5.10.149 compared to v5.10.140:
$ git log --format=oneline v5.10.140..v5.10.149
2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return value check of dma_get_required_mask()
e7fafef9830c4a01e60f76e3860a9bef0262378d scsi: mpt3sas: Force PCIe scatterlist allocations to be within same 4 GB region
ea10a652ad2ae2cf3eced6f632a5c98f26727057 scsi: mpt3sas: Fix use-after-free warning

Sreekanth and Suganath, can you help with bisecting this issue? For the
full report, see also https://lore.kernel.org/linux-scsi/Y1JkuKTjVYrOWbvm@eldamar.lan/.

Thanks,

Bart.
