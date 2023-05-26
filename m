Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC847126A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbjEZM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjEZM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:29:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEB11B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77489b6f68cso67118139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685104155; x=1687696155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tsqzyd/1Ooa7VgWYfvdbsvAr/ggONa2T3StzrXOi2xQ=;
        b=DXcPTRn/tkWI4NsDMesMFi45QLF5LnaIAGT7k0w46t7h2ESwhSsI3eT72xuOmvMcUA
         4NhRTxvJQjHyIPeWq0IgFsQmawEqaEytJ6M/t6jykIF3KxBltVL+G9vh7paonkmDxBT0
         j1COOdVWZ+D5FyKc1mizQeZAOzTq/tjyrMglyDrx4Nicu9LvKOgakwLv0OOU3oq+6PcI
         Ka3UFTTBjOwwNy16AND1d12xSpookbzANRewprDcpnmAJSulxzG4HuMarA6t2MPE9CcH
         3rC3+wCcSrAi3wwevgTrth3goklJ82rOUW2oUNnG2L3S13JR+fybL3/t6E+7wkVSx1Gu
         2a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685104155; x=1687696155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tsqzyd/1Ooa7VgWYfvdbsvAr/ggONa2T3StzrXOi2xQ=;
        b=SRG4U1/LCT+M2gAcx80Iw7NGAaV9rTZAMJ7/LQpPEi/989Nu62aKN5+K/hp/y5H/fK
         65F7gJ+Dj+aYiQgQJPT/wQ2kuNRC0Z5bhdUFE5av7f7w4Ng6CLzGe5IGIQ4RcoGeHPW2
         eY3NkffP2WsjmWfjhPA41tamDkdYGf53bgfN3qJYDrqKdMkifqFcPGCDM6bVb8lcU29I
         e0nL+5Kse0fh14lqISjhoyw4lGJtD3FZnF5buU8p9VwWOyWI/f+OWDrgyuqYR1rpMs51
         PmnfEUvyXDaXM6nOmHimJhbnOX5v7g6M9lhLBcxAbvrhV7Ze2LetFiI63MCNMajZtvTj
         tPQQ==
X-Gm-Message-State: AC+VfDwu09cFYy9slYlTXbV+Lg2RN3JgtQE1awyy9B6T1JgwrfEP2x8Q
        vA1Kop90GTrJm0kMv7z6AnYFsQ==
X-Google-Smtp-Source: ACHHUZ43WlhKqKbvj7lTOsfxXu8Pwq0lXrI1ST8N/Cv77/s7lc6LKs55JvkokjUQuBnGLvCP2QN3RA==
X-Received: by 2002:a5e:9242:0:b0:774:8d99:184c with SMTP id z2-20020a5e9242000000b007748d99184cmr1078630iop.11.1685104155628;
        Fri, 26 May 2023 05:29:15 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id m13-20020a0566380acd00b0041a8df29ad7sm1062334jab.38.2023.05.26.05.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 05:29:15 -0700 (PDT)
Message-ID: <d058ef04-6858-51a7-20e2-95b4f971a32d@linaro.org>
Date:   Fri, 26 May 2023 07:29:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: IPA_STATUS_SIZE, commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
To:     Bert Karwatzki <spasswolf@web.de>,
        Alex Elder <alex.elder@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <8a1beef0bc605756f8a45acf86f6bb58c188ae21.camel@web.de>
 <e8391577-3883-9e31-b5a5-b407927a56d5@linaro.org>
 <f936f513a9239e8d9824e964db2f84f232daf3e7.camel@web.de>
Content-Language: en-US
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <f936f513a9239e8d9824e964db2f84f232daf3e7.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 5:12 PM, Bert Karwatzki wrote:
> Am Mittwoch, dem 17.05.2023 um 16:35 -0500 schrieb Alex Elder:
>> On 5/12/23 8:04 AM, Bert Karwatzki wrote:
>>> commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
>>> Author: Alex Elder <elder@linaro.org>
>>> Date:   Wed Jan 25 14:45:39 2023 -0600
>>>
>>>       net: ipa: stop using sizeof(status)
>>>       
>>>       The IPA packet status structure changes in IPA v5.0 in ways
>>> that
>>> are
>>>       difficult to represent cleanly.  As a small step toward
>>> redefining
>>>       it as a parsed block of data, use a constant to define its
>>> size,
>>>       rather than the size of the IPA status structure type.
>>>       
>>>       Signed-off-by: Alex Elder <elder@linaro.org>
>>>       Signed-off-by: David S. Miller <davem@davemloft.net>
>>>
>>> introduced the IPA_STATUS_SIZE constant as a replacent for
>>> sizeof(struct ipa_status). IPA_STATUS_SIZE is defined as
>>> sizeof(__le32[4]), but sizeof(struct ipa_status) =
>>> sizeof(__le32[8])
>>> and the newly introducded ipa_status_extract operates on 8 __le32
>>> words, so I wondered if IPA_STATUS_SIZE is correct.
>>
>> You are right to wonder about this.  I think you have identified
>> a bug.  It is a bug that most likely almost never matters (because
>> the status size is always proper--and not too small), but it is
>> a bug nevertheless.
>>
>> Would you like to provide a patch to fix this?  Otherwise I can
>> do that, and I'll provide credit to you:
>>
>>       Reported-by: Bert Karwatzki <spasswolf@web.de>
>>
>> Please let me know.  Thanks for inquiring about/reporting this.
>>
>>                                          -Alex
>>
>>>
>>> Bert Karwatzki
>>
> 
> Here's the patch that addresse the issue (if there's a > in front of
> the first From, that seems to be a quirk of evolution ...)

Your patch looks correct, and again I really appreciate your
finding and fixing it.  Since the ipa_status structure is no
longer defined, I might now suggest just defining the value
as ((size_t)32), but that's not a big deal

To get your patch accepted, please re-send it, taking into
account the following:
- Make sure your patch is based on the upstream "net" branch:
     Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
     Branch: main
   (For this trivial fix this might not be critical.)
- Update your subject line, something like:
     [PATCH net] net: ipa: use proper value for IPA_STATUS_SIZE
   Be sure to include the "net" part; it indicates that the patch
   is a bug fix and should be back-ported.
- Add a one or two sentence description in the patch header.
   Something like:
     A recent commit introduced the IPA_STATUS_SIZE constant as
     a replacement for sizeof(struct ipa_status).  IPA_STATUS_SIZE
     was defined as sizeof(__le32[4]) (16 bytes), which is incorrect.
     The actual size of that (since removed) structure was 32 bytes,
     or sizeof(__le32[8]).  Correct the incorrect value.
- At the end,  add your sign-off:
     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
- And on the line directly above your sign-off, add a "Fixed"
   tag to indicate where the bug got introduced:
     Fixes: b8dc7d0eea5a ("net: ipa: stop using sizeof(status)")
- Address the patch message to the network maintainers, who
   can incorporate it into their current "net" branch, and
   arrange for the fix to be back-ported to older stable
   branches.
     David S. Miller <davem@davemloft.net>
     Eric Dumazet <edumazet@google.com>
     Jakub Kicinski <kuba@kernel.org>
     Paolo Abeni <pabeni@redhat.com>
- Carbon-copy me, and some mailing lists:
     Alex Elder <elder@linaro.org>
     netdev@vger.kernel.org
     linux-arm-msm@vger.kernel.org
     linux-kernel@vger.kernel.org

Once I receive the updated patch (assuming everything is
order), I will add my "Reviewed-by" and the network
maintainers can merge it and begin the process to get it
back-ported to earlier releases.

If you like, I can do all of this on your behalf.  Provided
you give me your sign-off (i.e., just send me a message that
includes "Signed-off-by: Bert Karwatzki <spasswolf@web.de>")
I can send it and will credit you for identifying the bug
and sending the fix.

					-Alex


> 
> 
>  From 583f35b3d91f048d413fc4f6a3b9237fc9d7efb2 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Fri, 19 May 2023 00:02:55 +0200
> Subject: [PATCH] Make IPA_STATUS_SIZE equal to the size of the remove
> struct
>   ipa_status.
> 
> ---
>   drivers/net/ipa/ipa_endpoint.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_endpoint.c
> b/drivers/net/ipa/ipa_endpoint.c
> index 2ee80ed140b7..afa1d56d9095 100644
> --- a/drivers/net/ipa/ipa_endpoint.c
> +++ b/drivers/net/ipa/ipa_endpoint.c
> @@ -119,7 +119,7 @@ enum ipa_status_field_id {
>   };
>   
>   /* Size in bytes of an IPA packet status structure */
> -#define IPA_STATUS_SIZE			sizeof(__le32[4])
> +#define IPA_STATUS_SIZE			sizeof(__le32[8])
>   
>   /* IPA status structure decoder; looks up field values for a structure
> */
>   static u32 ipa_status_extract(struct ipa *ipa, const void *data,

