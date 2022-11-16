Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DAB62C864
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiKPSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiKPSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:54:55 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E364A0E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:53:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ft34so46284380ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCRx1P+KwMIztXXzalL7wF+4lXeQ0p/A8da8gIDiFwQ=;
        b=Uq9Zt/Gmp3WIvxBD1gMCjIU/KRgYsEY9WKnbj7NbuZ5HDFbLrHQeQKhn+ffrijGFV9
         PcxhhqthdvY5WS2yzEhRi8U5+sCc5V2Lfc0crcQbRVsrH4Tkkq1XCQ8Cy4rKnY5yxXl+
         z+2oC339xvacLBMbZUZwJjPBfcVbw2RzYRnzwXh761WMtlCZbBBAuiImvToc+g3JBxGW
         NBtq6zjFlw1zKZQ9CHQEgQB8otHusvHwYWaJYNyBEVRzZN4IjpKIVlXTYOffUYmI41b5
         +9fNBt5O3smedH28J2k3jLN3Whyu+VaWnHwfro0j14w9IHVNs3M29lQJBrwlc6fbrMgh
         c1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCRx1P+KwMIztXXzalL7wF+4lXeQ0p/A8da8gIDiFwQ=;
        b=DpzViszu8P3RKzTrh3eF8LbJoKwRAL0suop0oiOG3yeLw0kDPKYz1QXrRyejhA7AGQ
         vKFiRRD/NIPYtn8m759dY2hGLORZIHD79ADg1/fjzZgIPZeUwWIYK6MDpK2MU186g5ix
         RdcA6VdaiB3uDgYsT/e2WS309KWdO7qQ294Nodxz/iJACv6gMvqXaYf6JMern58kqHsR
         wmzvCe221jNhS3jquGq1DOBAnx1ugFdcB1cD6HWiaXWv/iDxJXI+4lzsSVyT8cMC0lWi
         7H94uC3oniroN58Z/MtZHR/QaJjYlgPpCbbES7AmzzmXqsRGv1Z1/TP/8QzZwWuxFrFY
         uAOw==
X-Gm-Message-State: ANoB5pnrYUAtS5wjNkJpYENpP400UXgCCoYMmmcmSWyFwVvjmv+DcWRj
        a9z8Ug2TodxDtRdzO3k5h5A=
X-Google-Smtp-Source: AA0mqf4OONCebl/IGhnx1wS3TN6OxLZRKs0outOURgx4KO81i/2HnncYhoJDq6reZrYhI5MjI0Bj1w==
X-Received: by 2002:a17:906:79a:b0:73d:715c:5730 with SMTP id l26-20020a170906079a00b0073d715c5730mr18370075ejc.293.1668624822784;
        Wed, 16 Nov 2022 10:53:42 -0800 (PST)
Received: from ?IPV6:2003:c7:8f35:4b36:b14a:31a9:5cf4:bef4? (p200300c78f354b36b14a31a95cf4bef4.dip0.t-ipconnect.de. [2003:c7:8f35:4b36:b14a:31a9:5cf4:bef4])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709062cc100b00773c60c2129sm7291387ejr.141.2022.11.16.10.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:53:42 -0800 (PST)
Message-ID: <1f36ed17-73fa-c4f5-3e04-03d4295a2933@gmail.com>
Date:   Wed, 16 Nov 2022 19:53:41 +0100
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


Hi,

now I can tell you where the issue is:

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply 
--reject --ignore-space-change --ignore-whitespace 
~/Downloads/20221114-\[PATCH\ v3\]\ staging_\ vt6655_\ change\ the\ 
function\ name\ s_vFillRTSHead-5397.txt
Checking patch drivers/staging/vt6655/rxtx.c...
error: while searching for:
#define DATADUR_A_F1    13

/*---------------------  Static Functions  --------------------------*/
static void s_vFillRTSHead(struct vnt_private *pDevice,
			   unsigned char byPktType,
			   void *pvRTS,
			   unsigned int	cbFrameLength,
			   bool bNeedAck,
			   bool bDisCRC,
			   struct ieee80211_hdr *hdr,
			   unsigned short wCurrentRate,
			   unsigned char byFBOption);

static void s_vGenerateTxParameter(struct vnt_private *pDevice,
				   unsigned char byPktType,
				   struct vnt_tx_fifo_head *,

error: patch failed: drivers/staging/vt6655/rxtx.c:85
Hunk #3 succeeded at 567 (offset 22 lines).
Hunk #4 succeeded at 920 (offset 22 lines).
Hunk #5 succeeded at 939 (offset 22 lines).
Hunk #6 succeeded at 953 (offset 22 lines).
Applying patch drivers/staging/vt6655/rxtx.c with 1 reject...
Hunk #1 applied cleanly.
Rejected hunk #2.
Hunk #3 applied cleanly.
Hunk #4 applied cleanly.
Hunk #5 applied cleanly.
Hunk #6 applied cleanly.

Here how this place looks like in my repo:
#define DATADUR_A_F1    13

/*---------------------  Static Functions  --------------------------*/
static
void
s_vFillRTSHead(
	struct vnt_private *pDevice,
	unsigned char byPktType,
	void *pvRTS,
	unsigned int	cbFrameLength,
	bool bNeedAck,
	bool bDisCRC,
	struct ieee80211_hdr *hdr,
	unsigned short wCurrentRate,
	unsigned char byFBOption
);

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

switching branch

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git branch -a
* staging-next

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply 
--reject --ignore-space-change --ignore-whitespace 
~/Downloads/20221114-\[PATCH\ v3\]\ staging_\ vt6655_\ change\ the\ 
function\ name\ s_vFillRTSHead-5397.txt
Checking patch drivers/staging/vt6655/rxtx.c...
error: while searching for:
#define DATADUR_A_F1    13

/*---------------------  Static Functions  --------------------------*/
static void s_vFillRTSHead(struct vnt_private *pDevice,
			   unsigned char byPktType,
			   void *pvRTS,
			   unsigned int	cbFrameLength,
			   bool bNeedAck,
			   bool bDisCRC,
			   struct ieee80211_hdr *hdr,
			   unsigned short wCurrentRate,
			   unsigned char byFBOption);

static void s_vGenerateTxParameter(struct vnt_private *pDevice,
				   unsigned char byPktType,
				   struct vnt_tx_fifo_head *,

error: patch failed: drivers/staging/vt6655/rxtx.c:85
Hunk #3 succeeded at 567 (offset 22 lines).
Hunk #4 succeeded at 920 (offset 22 lines).
Hunk #5 succeeded at 939 (offset 22 lines).
Hunk #6 succeeded at 953 (offset 22 lines).
Applying patch drivers/staging/vt6655/rxtx.c with 1 reject...
Hunk #1 applied cleanly.
Rejected hunk #2.
Hunk #3 applied cleanly.
Hunk #4 applied cleanly.
Hunk #5 applied cleanly.
Hunk #6 applied cleanly.

Same issue.

Bye Philipp





