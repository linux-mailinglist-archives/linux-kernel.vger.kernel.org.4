Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4186291CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiKOGXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:23:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF8D49
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:23:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x102so5221504ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LhxSgwXjP7zJAv04ZdpOaD1c6/nMz+SUHh4hsP5H2g=;
        b=C+4j35jDEbsVTA4kIbANCTgP2J4fLEvYOhN1X1ls5VmnIRG+JMXbrRKnkSh+mpo9SX
         cXP8+KdbFQ42QHA7psKhUDE5qE7cMtKoLg0wjsaz4O9uQXZBQUeEm2BKdXtZ0b92GCTn
         0fkt3QMiPLaCoqE2TtsIyXrJAI7t/B4gPK11y4V+D8JnG4l9+Bu4iL5A0w0DG+dJatgv
         ao5FjZPbwF1TOShFFjByz1mcZL60E8s3lbreuMZ7aPfLy6u9S4H8UmCWTBKuHv+zKfzS
         Yxh47kArV3cUtBaNRB4JlfcmvHrrrjarJxduB9BM23CIrsh8tiyMhVjTnipNfcKBuCBk
         NCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LhxSgwXjP7zJAv04ZdpOaD1c6/nMz+SUHh4hsP5H2g=;
        b=CAQGBN9wOxioTDVIUktCbz3zKYRYWvKWKq/hzABbXhLaTNEUpequA0kX/V3BNHM+a8
         /2G8zAg7DBgk5P0cq/5yCQXRGV8+OPzUXUfpZXQMZr+SID/TMbXKC0uYwntJmmurUhxG
         eHh6f6zBGydLZ4S0Hw/Lto6xTT1+Y+iR6SX6ei9nUO7C48iJ0KQ0D7iF68/hofd8fduf
         cIsmt/2rFjqf0TAkWd3/RPMigIdrSfn/cHL76t1lbH6yN7sep1wTrOqRM9E5TpuDm77R
         tHj/Sz1yfb5A4MQlpxkxFgG2llXdXhE5G2rOrCuNLC/FZhIsQjwxPiR+NezQAipCMnTX
         GDtA==
X-Gm-Message-State: ANoB5pkPENOwG+dWn4bsVQdg/GB3ulmMnU8URqmMLOfUQdKQVQ8j86U4
        ZHD0ZLl5s6PC/UXO0BVofz6UBB3xlYQ=
X-Google-Smtp-Source: AA0mqf6MPOoddGY4z4236ZNbmPSIpvbI3Pg/N9lk7r2y22Kcec++BMuUaW1sFNC6IZRLqDz4bIPLlw==
X-Received: by 2002:aa7:de82:0:b0:45c:a651:87f1 with SMTP id j2-20020aa7de82000000b0045ca65187f1mr13816632edv.359.1668493420299;
        Mon, 14 Nov 2022 22:23:40 -0800 (PST)
Received: from ?IPV6:2003:c7:8f35:4b10:ee5:496e:6b0a:20dc? (p200300c78f354b100ee5496e6b0a20dc.dip0.t-ipconnect.de. [2003:c7:8f35:4b10:ee5:496e:6b0a:20dc])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b0078afe360800sm5012540ejc.199.2022.11.14.22.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 22:23:39 -0800 (PST)
Message-ID: <ad5b7656-53fd-059f-ed77-8617a5320f2f@gmail.com>
Date:   Tue, 15 Nov 2022 07:23:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] staging: vt6655: change the function name
 s_vFillRTSHead
Content-Language: en-US
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <Y3KJBdUue5otWgOT@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <480340b3-c1c1-74b5-1889-f49dcb644469@gmail.com>
 <CAHJEyKWRm_wzUcz7wzcveLLGND9F3m3HM23mpwQ=zjeO5zh5FA@mail.gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAHJEyKWRm_wzUcz7wzcveLLGND9F3m3HM23mpwQ=zjeO5zh5FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 23:59, Tanju Brunostar wrote:
> On Mon, Nov 14, 2022 at 9:19 PM Philipp Hortmann
> <philipp.g.hortmann@gmail.com> wrote:
>>
>> On 11/14/22 19:29, Tanjuate Brunostar wrote:
>>> Remove the use of Hungarian notation, which is not used in the Linux
>>> kernel. Reported by checkpatch
>>> Add indentation to the affected function to follow the Linux kernel
>>> coding style. This improves visibility
>>>
>>> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
>>> ---
>>> v2: corrected confusing changlog message on this patch
>>> v3: removed unnecessary function prototype
>>>
>>>    drivers/staging/vt6655/rxtx.c | 40 ++++++++++++-----------------------
>>>    1 file changed, 13 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
>>> index 31ae99b3cb35..715b323cd2a8 100644
>>> --- a/drivers/staging/vt6655/rxtx.c
>>> +++ b/drivers/staging/vt6655/rxtx.c
>>> @@ -23,7 +23,7 @@
>>>     *      s_uGetTxRsvTime- get frame reserved time
>>>     *      s_vFillCTSHead- fulfill CTS ctl header
>>>     *      s_vFillFragParameter- Set fragment ctl parameter.
>>> - *      s_vFillRTSHead- fulfill RTS ctl header
>>> + *      fill_rts_header- fulfill RTS ctl header
>>>     *      s_vFillTxKey- fulfill tx encrypt key
>>>     *      s_vSWencryption- Software encrypt header
>>>     *      vDMA0_tx_80211- tx 802.11 frame via dma0
>>> @@ -85,16 +85,6 @@ static const unsigned short fb_opt1[2][5] = {
>>>    #define DATADUR_A_F1    13
>>>
>>>    /*---------------------  Static Functions  --------------------------*/
>>> -static void s_vFillRTSHead(struct vnt_private *pDevice,
>>> -                        unsigned char byPktType,
>>> -                        void *pvRTS,
>>> -                        unsigned int cbFrameLength,
>>> -                        bool bNeedAck,
>>> -                        bool bDisCRC,
>>> -                        struct ieee80211_hdr *hdr,
>>> -                        unsigned short wCurrentRate,
>>> -                        unsigned char byFBOption);
>>> -
>>>    static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>>>                                   unsigned char byPktType,
>>>                                   struct vnt_tx_fifo_head *,
>>> @@ -555,19 +545,15 @@ s_uFillDataHead(
>>>        return buf->duration;
>>>    }
>>>
>>> -static
>>> -void
>>> -s_vFillRTSHead(
>>> -     struct vnt_private *pDevice,
>>> -     unsigned char byPktType,
>>> -     void *pvRTS,
>>> -     unsigned int cbFrameLength,
>>> -     bool bNeedAck,
>>> -     bool bDisCRC,
>>> -     struct ieee80211_hdr *hdr,
>>> -     unsigned short wCurrentRate,
>>> -     unsigned char byFBOption
>>> -)
>>> +static void fill_rts_header(struct vnt_private *pDevice,
>>> +                         unsigned char byPktType,
>>> +                         void *pvRTS,
>>> +                         unsigned int cbFrameLength,
>>> +                         bool bNeedAck,
>>> +                         bool bDisCRC,
>>> +                         struct ieee80211_hdr *hdr,
>>> +                         unsigned short wCurrentRate,
>>> +                         unsigned char byFBOption)
>>>    {
>>>        unsigned int uRTSFrameLen = 20;
>>>
>>> @@ -912,7 +898,7 @@ s_vGenerateTxParameter(
>>>                        buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>>>                        buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
>>>
>>> -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>> +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>>                } else {/* RTS_needless, PCF mode */
>>>                        struct vnt_rrv_time_cts *buf = pvRrvTime;
>>>
>>> @@ -931,7 +917,7 @@ s_vGenerateTxParameter(
>>>                        buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>>>
>>>                        /* Fill RTS */
>>> -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>> +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>>                } else if (!pvRTS) {/* RTS_needless, non PCF mode */
>>>                        struct vnt_rrv_time_ab *buf = pvRrvTime;
>>>
>>> @@ -945,7 +931,7 @@ s_vGenerateTxParameter(
>>>                        buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
>>>
>>>                        /* Fill RTS */
>>> -                     s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>> +                     fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>>>                } else { /* RTS_needless, non PCF mode */
>>>                        struct vnt_rrv_time_ab *buf = pvRrvTime;
>>>
>>
>> Hi,
>>
>> I cannot apply your patch.
>>
>> Here my git infos:
>> git remote show origin
>> * remote origin
>>     Fetch URL:
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>> ...
>> git branch -a
>> my branch: staging-testing
>>
>> Bye Philipp
> 
> I was recently asked to rebase to the staging-next branch. I think
> this is where there is conflict

I do not think so.
between this commit:
commit 335140116703920ddcbd9a09ae9edfb02902f3d1 (HEAD -> 
staging-testing, origin/staging-testing)
and this one:
commit a614e753e8e7f3322b560dcf6eaf44468ec22b3a (origin/staging-next)

are only 4 commits and non of them is regarding the vt6655.

So this should work.

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git status
On branch staging-testing
Your branch is up to date with 'origin/staging-testing'.

nothing to commit, working tree clean
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git pull
Already up to date.
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ cat 
~/Downloads/20221114-\[PATCH\ v3\]\ staging_\ vt6655_\ change\ the\ 
function\ name\ s_vFillRTSHead-5397.txt | git am
Applying: staging: vt6655: change the function name s_vFillRTSHead
error: patch failed: drivers/staging/vt6655/rxtx.c:85
error: drivers/staging/vt6655/rxtx.c: patch does not apply
Patch failed at 0001 staging: vt6655: change the function name 
s_vFillRTSHead
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$

Bye Philipp



