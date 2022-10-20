Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C1606744
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJTRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJTRrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:47:46 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026F1A2E03;
        Thu, 20 Oct 2022 10:47:45 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id p6so11656plr.7;
        Thu, 20 Oct 2022 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubHPEpEE91JnOIoaIT4hlW8hHg5fJdATVwQ91Dm4tLg=;
        b=kTZU6DLluc4VRliEjybd9kxI82JOzCr3S8KNfyDVplsHKul1YDMY1hgK0ONRFXCL6c
         RgMS9BbOuQZqm8+HNgVJ1eZwMfNBXZaFu1lCtcWcV3V0ju2cdnHtFsylyIeYVWxkYUoA
         sSRRKYA3RaWrFuoB3hmUoi7v2RGSy06cYJi19lOLcv947trBm3/OKs0moHE/gzR57g/Y
         9GtUzBw1CNcUZ5mBVAI4J2Ip3XEuiuT+BQ60KOSht3VcaDXXwkxR4ObdzEH1kEsAiw0V
         Ck7gnrEjlUfrWKOI5w9irw26eeXIXl7OLW4FHEf6wA1A69L1wSeespk4Uj2WQuJvmkCW
         jFKA==
X-Gm-Message-State: ACrzQf3VqGrERZ6YhD1P7V3/HpSs3rxFsEFvNhRYlVqmM1uWrlLmvES2
        fGKBgCsxJ6YxAR6+mlDf0Hw=
X-Google-Smtp-Source: AMsMyM4zjYZrPLmloYRRsvabfTKbMbsj/5xF8KNUlV7+rK/24XNFdd7JuzIEglrWrPIF83vIuGj38Q==
X-Received: by 2002:a17:902:6945:b0:17b:f38b:900f with SMTP id k5-20020a170902694500b0017bf38b900fmr15091774plt.85.1666288065168;
        Thu, 20 Oct 2022 10:47:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e10c:786f:1f97:68bc? ([2620:15c:211:201:e10c:786f:1f97:68bc])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b00177f4ef7970sm13496362plh.11.2022.10.20.10.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:47:44 -0700 (PDT)
Message-ID: <828a4157-09c3-3fc5-175e-b4da508a35d0@acm.org>
Date:   Thu, 20 Oct 2022 10:47:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
Content-Language: en-US
To:     =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>,
        Bean Huo <huobean@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
 <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
 <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com>
 <8678f69aa94003b357c4c8ef42cd6ce5c7487f8d.camel@gmail.com>
 <CAFN68yUKXquOLqL_6oBRjfDGDT=NgQPF3cpo7bkHyJ1gNTDbZA@mail.gmail.com>
 <CAFN68yVLdwrJBivqjGfGd7qiGp_h8FwucBLvSH97wNiyik4nQw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFN68yVLdwrJBivqjGfGd7qiGp_h8FwucBLvSH97wNiyik4nQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 22:15, 高严凯 wrote:
> Do you agree this patch? I'd like to hear your opinion about this.

Hi,

On Linux kernel mailing lists it is expected that replies are posted 
below the original email instead of above. Please follow this 
convention. More information is available at 
https://en.wikipedia.org/wiki/Posting_style#Bottom-posting.

Please also do the following:
* Fix the issues reported by the kernel test robot.
* Follow the recommendations from Avri and Bean.

Thanks,

Bart.

