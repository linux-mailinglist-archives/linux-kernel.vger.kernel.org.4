Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639065BEB41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiITQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:40:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42761D67;
        Tue, 20 Sep 2022 09:40:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w8so4691823lft.12;
        Tue, 20 Sep 2022 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=Y5Wgrjryn2Tie7R2qmyUxcsPMfW+Q9FhfB5/RzMRR1U=;
        b=DslBfnjlx5Ie8lv0lC8eTx4266TEbJKrxGT+aZsKVUyAYr156mtQns5yYREjtZl6WT
         OamSeHmGlZ2cc9E2ev2LzmNfPx1QsxL2ZfSLcfIwAlHQGJqWtpxtSYsY3AjvwJj3m7r/
         ThKRjcrLrkrHZCOhSWuPWz9rg2hPvJylEpUm1TLbbX8+MC+ITHqS1s2RA2pf/dDAboAS
         nzmJrU9JW+NhmgS/nC/YGYrqQicYeqQ36UMPllgowXySfju9PCYoLntLCKIy/7LK+Fae
         T3c/6Gpt55XKo9yfgHqrq0Y1ZrgVMddSMarrZk+pi+t+1UE45KvUEGGU0Pcxpl/L/W6b
         MhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=Y5Wgrjryn2Tie7R2qmyUxcsPMfW+Q9FhfB5/RzMRR1U=;
        b=ChozxGgYpkSragvGK+yLtfpWTXIXp486oCQZUfz72TiodNvpt+uyUxH2puBhyE18Ad
         1RSsN8/JNbSPJyp439yeCKvxnJw1Y633EbDH2JmadxfH1M7HUp+BWkZr+s1SDMZ23TR4
         /pxviSqHfQaEh7sxxxAerpnKcz9JV8ejJWnagWe/zU6A7HR2eFX3zhQmIJWCsmcPB8EN
         z54H/XjQc3emph7ClgQ8CTSMgDJ/aizkHr7TyMESDPy3CTiNtmbq9cqeNUrO1xGgaYhj
         LarZmV8wUxbjy8KRLmG0EPRSsulCIfcL3njnVYXG1L1i6OJAonm6VX3RsfgMA3c63n8I
         ITQg==
X-Gm-Message-State: ACrzQf2vqk2FNjvkh7TBOINWV3fTo1GxcZGFqVzuNK0yU9JYs9ABWsK5
        n4kVw3khGcSbV0ELSElw71l1MYAFljayYA==
X-Google-Smtp-Source: AMsMyM47sKwn+jUkJgoEFYbjX85HLfRTbaa8oN1P8O+7OiXqZiaEDfJ4fsp0CC/73er7LbhRlQWFKg==
X-Received: by 2002:ac2:5ece:0:b0:497:acb3:a6f5 with SMTP id d14-20020ac25ece000000b00497acb3a6f5mr8847579lfq.112.1663692034928;
        Tue, 20 Sep 2022 09:40:34 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b004998d9ccb62sm41007lfo.99.2022.09.20.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:40:33 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
 <87czbwp9xx.fsf@gmail.com> <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
 <87wn9zreic.fsf@gmail.com> <YyhE5voxRz7gEYHY@paasikivi.fi.intel.com>
 <YyhzUvu0Ky8+VohC@pendragon.ideasonboard.com>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Date:   Tue, 20 Sep 2022 18:55:50 +0300
In-reply-to: <YyhzUvu0Ky8+VohC@pendragon.ideasonboard.com>
Message-ID: <87sfkmj8xs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FREEMAIL_DOC_PDF
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hi Laurent,

On 2022-09-19 at 16:49 +03, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hello,
>
> On Mon, Sep 19, 2022 at 10:31:02AM +0000, Sakari Ailus wrote:
>> On Mon, Sep 19, 2022 at 10:01:06AM +0300, Mikhail Rudenko wrote:
>> > On 2022-09-19 at 06:40 GMT, Sakari Ailus wrote:
>> > > On Fri, Sep 16, 2022 at 12:27:42AM +0300, Mikhail Rudenko wrote:
>> > >> On 2022-09-14 at 10:58 +01, Dave Stevenson wrote:
>> > >> > On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko wrote:
>> > >> >>
>> > >> >> Hello,
>> > >> >>
>> > >> >> this series implements support for Omnivision OV4689 image
>> > >> >> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
>> > >> >> megapixel image sensor. Ihis chip supports high frame rate speeds up
>> > >> >> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
>> > >> >> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> > >> >> connection.
>> > >> >>
>> > >> >> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
>> > >> >> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
>> > >> >> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera
>> > >> >> module.
>> > >> >> While porting the driver, I stumbled upon two issues:
>> >
>> > [snip]
>> >
>> > >> >> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
>> > >> >> gain is not linear across that range. Instead, it is piecewise linear
>> > >> >> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
>> > >> >> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
>> > >> >> with more linear segments in between. Rockchip's camera engine code
>> > >> >> chooses one of the above segments depenging on the desired gain
>> > >> >> value. The question is, how should we proceed keeping in mind
>> > >> >> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
>> > >> >> libcamera will do the mapping, or the driver will do the mapping
>> > >> >> itself and expose some logical gain units not tied to the actual gain
>> > >> >> register value? Meanwhile, this driver conservatively exposes only
>> > >> >> 0x0-0xf8 gain register range.
>> > >> >
>> > >> > The datasheet linked above says "for the gain formula, please contact
>> > >> > your local OmniVision FAE" :-(
>> > >> > I would assume that the range is from 1x rather than 0x - people
>> > >> > rarely want a totally black image that 0x would give. Or is it ranges
>> > >> > of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?
>> > >>
>> > >> A picture is worth a thousand words, so I've attached the results of my
>> > >> experimentation with the gain register. They were obtained with Rockchip
>> > >> 3399, with AEC, AGC and black level subtraction disabled. The image was
>> > >> converted from 10-bit RGGB to 8-bit YUV 4:2:0 by the Rockchip ISP.
>
> Is that full or limited range YUV ?
>

That is default rkisp1 setting, supposedly limited range. This is
consistent with the fact that I have not seen brightness less than 19
and more than 235.

>> > > Based on that it looks like their medication may have been a
>> > > little too strong.
>> > >
>> > > Could this be implemented so that the control value would be linear linear
>> > > but its range would correspond 1x--16x values?
>> > >
>> > > libcamera will be able to cope with that.
>> >
>> > According to the following fragment of the Rockchip camera engine sensor
>> > configuration file for ov4689 [1]
>> >
>> >     <Linear index="1" type="double" size="[4 7]">
>> >        [1 2 128 0 1 128 255
>> >         2 4 64 -248 1 376 504
>> >         4 8 32 -756 1 884 1012
>> >         8 16 16 -1784 1 1912 2040]
>> >     </Linear>,
>> >
>> > it uses gain register value range 128-255 for gain 1x-2x, 376-504 for
>> > gain 2x-4x, 884-1024 for 4x-8x, and 1912-2040 for 8x-16x. Do you suggest
>
> That looks *really* weird. I would have understood [384, 511], [896,
> 1023] and [1920, 2047], but not those intervals.
>
> The driver hardcodes bit 0x3503[2] to 1, which means "sensor gain
> format". Maybe setting it to 0 ("real gain format") would produce saner
> results ?

I've also found this bit when running the tests. I'll attach high
quality plots and raw data for both formats to this message. Overall,
"real gain format" looks a bit saner, though it probably needs gain
codes > 2048 to achieve 16x gain (not tested).

I decided to use "sensor gain format" only because it was one used in
the BSP driver. Now it looks like "real gain format" may be a better
choice. I'll rerun the tests with gain code range 0-4096. If we'll have
0-16x gain over the range 2048-4096 in "real gain format" (this is
expected from existing data), I'll just expose that for
CID_ANALOGUE_GAIN, no need to use piecewise mapping.

>> > to implement this calculation in the sensor driver and expose some
>> > linear "logical" gain to userspace (ranging, e.g., 128-2048 for gains
>> > 1x-16x)?
>>
>> Yes. This way the user space can somehow work without knowing this special
>> implementation, even though the granularity changes over the range. I guess
>> the granularity would need to be known in libcamera but that's a separate
>> issue.
>
> I can live with that.

--
Best regards,
Mikhail Rudenko

--=-=-=
Content-Type: application/pdf
Content-Disposition: attachment; filename=gain-test.3503_00.pdf
Content-Transfer-Encoding: base64

JVBERi0xLjQKJcOiw6MKMSAwIG9iago8PAovVGl0bGUgKCkKL0NyZWF0b3IgKCkKL1Byb2R1Y2Vy
ICj+/wBRAHQAIAA1AC4AMQA1AC4ANikKL0NyZWF0aW9uRGF0ZSAoRDoyMDIyMDkyMDE4NTI0Mysw
MycwMCcpCj4+CmVuZG9iagoyIDAgb2JqCjw8Ci9UeXBlIC9DYXRhbG9nCi9QYWdlcyAzIDAgUgo+
PgplbmRvYmoKNCAwIG9iago8PAovVHlwZSAvRXh0R1N0YXRlCi9TQSB0cnVlCi9TTSAwLjAyCi9j
YSAxLjAKL0NBIDEuMAovQUlTIGZhbHNlCi9TTWFzayAvTm9uZT4+CmVuZG9iago1IDAgb2JqClsv
UGF0dGVybiAvRGV2aWNlUkdCXQplbmRvYmoKNiAwIG9iago8PAovVHlwZSAvUGFnZQovUGFyZW50
IDMgMCBSCi9Db250ZW50cyA4IDAgUgovUmVzb3VyY2VzIDEwIDAgUgovQW5ub3RzIDExIDAgUgov
TWVkaWFCb3ggWzAgMCA2NDAuMDAwMDAwIDQ4MC4wMDAwMDBdCj4+CmVuZG9iagoxMCAwIG9iago8
PAovQ29sb3JTcGFjZSA8PAovUENTcCA1IDAgUgovQ1NwIC9EZXZpY2VSR0IKL0NTcGcgL0Rldmlj
ZUdyYXkKPj4KL0V4dEdTdGF0ZSA8PAovR1NhIDQgMCBSCj4+Ci9QYXR0ZXJuIDw8Cj4+Ci9Gb250
IDw8Ci9GNyA3IDAgUgo+PgovWE9iamVjdCA8PAo+Pgo+PgplbmRvYmoKMTEgMCBvYmoKWyBdCmVu
ZG9iago4IDAgb2JqCjw8Ci9MZW5ndGggOSAwIFIKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3Ry
ZWFtCnic3Z1dj+bGcbbP51c8xy/gEfu7CQQBbMUOkIMAhhZ4D4IcBDISw9AaEXSQvx82P+q+ukmu
dnZnNZuVYOuZa2qK3cUqsrt5s5/v/vmH/3j81y+P777/4b8fP+7//f6Hp+k5T/s/j/bv73oQ6/T4
8f3Tz4+fn/789Ofl/4//tl++f3JTLsuHn7YPdWofJ/tv+/+/Pv3///f4+/pn2//cc97/WY83/Lgc
a2mALzFN83Lo4XMMLhSf4uOH7/91sUvW0P95uMe/LP/72+PfiN3j36fH4y9PJR7wEad5/7w0P7t0
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
fWdvw4PaXSOcjTtO/PC/XkJcGA9kc6kTT2oYGmADpTohUD88TY/27w/f/+uTe/zPwz/+Zfnf3x7/
9u/T4/GXpz8//fy0XET2f1bL4ccf33/YQ/9Lt/zS6Zcm+Jge9rrv9HhPHjkdyc7ubXccfn668f/T
018/r99N9FtD++eR069G4Gv19fPTd9//8N+PH395bGa//Pj3p+/++Yf/ePzXL09/ePf03Z/aA/LH
u/9cTlj79e+2/7zbvL77y+Mfpsn98R8f7/72tAwnvKulyQqP30xh/c1y2SjVef7G/Wn9Tbn4m3T3
N1O5/c3tce69+em21W79TRvBTbn/G3d7nNu/+aQY3Pdn+80f3y1JsPz7+Hk5gR/Olcefn/4XH9/X
3gplbmRzdHJlYW0KZW5kb2JqCjkgMCBvYmoKMTA1NDIKZW5kb2JqCjEyIDAgb2JqCjw8IC9UeXBl
IC9Gb250RGVzY3JpcHRvcgovRm9udE5hbWUgL1FNQUFBQStOb3RvU2Fucy1SZWd1bGFyCi9GbGFn
cyA0IAovRm9udEJCb3ggWy02MjEgLTM4OSAyODAwIDEwNjcgXQovSXRhbGljQW5nbGUgMCAKL0Fz
Y2VudCAxMDY5IAovRGVzY2VudCAtMjkzIAovQ2FwSGVpZ2h0IDEwNjkgCi9TdGVtViA1MCAKL0Zv
bnRGaWxlMiAxMyAwIFIKL0NJRFNldCAxNiAwIFIKPj4KZW5kb2JqCjEzIDAgb2JqCjw8Ci9MZW5n
dGgxIDY0NDAgCi9MZW5ndGggMTcgMCBSCi9GaWx0ZXIgL0ZsYXRlRGVjb2RlCj4+CnN0cmVhbQp4
nJVXe1RTZ7b/9jknCeALkIeKSEKEAAoBYhIBQXmFkAQoDwEpIiEJz5AACQq1lFLr1GqtIsosW+u4
Wtta1yztdCxze6fTGacP21rHe2/r6pp7p2vN3F5nukb7WL1rOrcKh7u/75xosf1jJifnnL2/s79v
v357f+cQIISEkYcJT0hNvT734Pm9W3HkCTzbu7yjna/85Nh7SN8kZPG/dHucbs/+Si0hS07jmKkb
BxQ/j/w78n9Afm13f3Dk8ZeXLiJkKbJkn9fvchY9WWBEfh/yln7nyABJJVXI/xvyap+z3+M+qbmK
/FeERJiIwFngMFEQwu3nmlHCLt2hjeRCCY4uUnCCQuA44Y+Em99C1ElhhKSTSEIqamoqyBZC5ueE
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
czJEUTsHmIX9LJahjATk+Lnl/PczX2jV331OcbqTzfXdqbBRhuwhhhHJJqlig/9AVu+thwBaTDM7
wDpvFrPNi3fqYxc+p5F34ApeNtLDYhNAC/oRC34cbWA2e+/YRvt5ULbXyagAw8VdT20LYrhwdkjG
Ke8KLqQGmEYPs1qSC6AWl5yTEBormHce1r/qEUU9rDqdbC33Ai8X9sQmhiBp52mQO3g5okjqi447
z+5SC+dXMf09yPczVNEclrDIuO/c765394nUo/pQfw/yNHOlLGfu7/SA74+ENHz/STWLaD+LXKmc
faoxIO9HND5+OR+DaK0Hd6YGVi9BrKQehmJq0ygh/w8GVV+TCmVuZHN0cmVhbQplbmRvYmoKMTcg
MCBvYmoKNDE5OAplbmRvYmoKMTQgMCBvYmoKPDwgL1R5cGUgL0ZvbnQKL1N1YnR5cGUgL0NJREZv
bnRUeXBlMgovQmFzZUZvbnQgL05vdG9TYW5zLVJlZ3VsYXIKL0NJRFN5c3RlbUluZm8gPDwgL1Jl
Z2lzdHJ5IChBZG9iZSkgL09yZGVyaW5nIChJZGVudGl0eSkgL1N1cHBsZW1lbnQgMCA+PgovRm9u
dERlc2NyaXB0b3IgMTIgMCBSCi9DSURUb0dJRE1hcCAvSWRlbnRpdHkKL1cgWzAgWzYwMCAyNjAg
XQoyIDExIDU3MiAKMTIgWzkwNyA1NjQgNTYxIDYxOCA1NjYgNzI4IDI1OCA0ODAgNjA1IDYxNSAy
MjUgNjE1IDMyMiAzNjEgNDc5IDI2OCA0NDQgMjU4IDMyOSA1MjkgMzI5IDU3MiBdCl0KPj4KZW5k
b2JqCjE1IDAgb2JqCjw8IC9MZW5ndGggNTk1ID4+CnN0cmVhbQovQ0lESW5pdCAvUHJvY1NldCBm
aW5kcmVzb3VyY2UgYmVnaW4KMTIgZGljdCBiZWdpbgpiZWdpbmNtYXAKL0NJRFN5c3RlbUluZm8g
PDwgL1JlZ2lzdHJ5IChBZG9iZSkgL09yZGVyaW5nIChVQ1MpIC9TdXBwbGVtZW50IDAgPj4gZGVm
Ci9DTWFwTmFtZSAvQWRvYmUtSWRlbnRpdHktVUNTIGRlZgovQ01hcFR5cGUgMiBkZWYKMSBiZWdp
bmNvZGVzcGFjZXJhbmdlCjwwMDAwPiA8RkZGRj4KZW5kY29kZXNwYWNlcmFuZ2UKMiBiZWdpbmJm
cmFuZ2UKPDAwMDA+IDwwMDAwPiA8MDAwMD4KPDAwMDE+IDwwMDIxPiBbPDAwMDk+IDwwMDMxPiA8
MDAzMD4gPDAwMzI+IDwwMDMzPiA8MDAzND4gPDAwMzU+IDwwMDM2PiA8MDAzNz4gPDAwMzg+IDww
MDM5PiA8MDA0RD4gPDAwNjU+IDwwMDYxPiA8MDA2RT4gPDAwNTk+IDwwMDQ3PiA8MDA2OT4gPDAw
NjM+IDwwMDZGPiA8MDA2ND4gPDAwMjc+IDwwMDY3PiA8MDAyRD4gPDAwNzQ+IDwwMDczPiA8MDAy
RT4gPDAwNUY+IDwwMDZDPiA8MDA1Qj4gPDAwNzg+IDwwMDVEPiA8MDAzRD4gXQplbmRiZnJhbmdl
CmVuZGNtYXAKQ01hcE5hbWUgY3VycmVudGRpY3QgL0NNYXAgZGVmaW5lcmVzb3VyY2UgcG9wCmVu
ZAplbmQKCmVuZHN0cmVhbQplbmRvYmoKNyAwIG9iago8PCAvVHlwZSAvRm9udAovU3VidHlwZSAv
VHlwZTAKL0Jhc2VGb250IC9Ob3RvU2Fucy1SZWd1bGFyCi9FbmNvZGluZyAvSWRlbnRpdHktSAov
RGVzY2VuZGFudEZvbnRzIFsxNCAwIFJdCi9Ub1VuaWNvZGUgMTUgMCBSPj4KZW5kb2JqCjE2IDAg
b2JqCjw8Ci9MZW5ndGggNQo+PgpzdHJlYW0K/////8AKZW5kc3RyZWFtCmVuZG9iagozIDAgb2Jq
Cjw8Ci9UeXBlIC9QYWdlcwovS2lkcyAKWwo2IDAgUgpdCi9Db3VudCAxCi9Qcm9jU2V0IFsvUERG
IC9UZXh0IC9JbWFnZUIgL0ltYWdlQ10KPj4KZW5kb2JqCnhyZWYKMCAxOAowMDAwMDAwMDAwIDY1
NTM1IGYgCjAwMDAwMDAwMTUgMDAwMDAgbiAKMDAwMDAwMDEzMSAwMDAwMCBuIAowMDAwMDE2OTc5
IDAwMDAwIG4gCjAwMDAwMDAxODAgMDAwMDAgbiAKMDAwMDAwMDI3NSAwMDAwMCBuIAowMDAwMDAw
MzEyIDAwMDAwIG4gCjAwMDAwMTY3ODIgMDAwMDAgbiAKMDAwMDAwMDYzMiAwMDAwMCBuIAowMDAw
MDExMjQ4IDAwMDAwIG4gCjAwMDAwMDA0NDYgMDAwMDAgbiAKMDAwMDAwMDYxMiAwMDAwMCBuIAow
MDAwMDExMjY5IDAwMDAwIG4gCjAwMDAwMTE0OTcgMDAwMDAgbiAKMDAwMDAxNTgwNyAwMDAwMCBu
IAowMDAwMDE2MTM1IDAwMDAwIG4gCjAwMDAwMTY5MjQgMDAwMDAgbiAKMDAwMDAxNTc4NiAwMDAw
MCBuIAp0cmFpbGVyCjw8Ci9TaXplIDE4IAovSW5mbyAxIDAgUgovUm9vdCAyIDAgUgo+PgpzdGFy
dHhyZWYKMTcwNzcgCiUlRU9GCg==
--=-=-=
Content-Type: application/pdf
Content-Disposition: attachment; filename=gain-test.3503_04.pdf
Content-Transfer-Encoding: base64

JVBERi0xLjQKJcOiw6MKMSAwIG9iago8PAovVGl0bGUgKCkKL0NyZWF0b3IgKCkKL1Byb2R1Y2Vy
ICj+/wBRAHQAIAA1AC4AMQA1AC4ANikKL0NyZWF0aW9uRGF0ZSAoRDoyMDIyMDkyMDE4NTIwMisw
MycwMCcpCj4+CmVuZG9iagoyIDAgb2JqCjw8Ci9UeXBlIC9DYXRhbG9nCi9QYWdlcyAzIDAgUgo+
PgplbmRvYmoKNCAwIG9iago8PAovVHlwZSAvRXh0R1N0YXRlCi9TQSB0cnVlCi9TTSAwLjAyCi9j
YSAxLjAKL0NBIDEuMAovQUlTIGZhbHNlCi9TTWFzayAvTm9uZT4+CmVuZG9iago1IDAgb2JqClsv
UGF0dGVybiAvRGV2aWNlUkdCXQplbmRvYmoKNiAwIG9iago8PAovVHlwZSAvUGFnZQovUGFyZW50
IDMgMCBSCi9Db250ZW50cyA4IDAgUgovUmVzb3VyY2VzIDEwIDAgUgovQW5ub3RzIDExIDAgUgov
TWVkaWFCb3ggWzAgMCA2NDAuMDAwMDAwIDQ4MC4wMDAwMDBdCj4+CmVuZG9iagoxMCAwIG9iago8
PAovQ29sb3JTcGFjZSA8PAovUENTcCA1IDAgUgovQ1NwIC9EZXZpY2VSR0IKL0NTcGcgL0Rldmlj
ZUdyYXkKPj4KL0V4dEdTdGF0ZSA8PAovR1NhIDQgMCBSCj4+Ci9QYXR0ZXJuIDw8Cj4+Ci9Gb250
IDw8Ci9GNyA3IDAgUgo+PgovWE9iamVjdCA8PAo+Pgo+PgplbmRvYmoKMTEgMCBvYmoKWyBdCmVu
ZG9iago4IDAgb2JqCjw8Ci9MZW5ndGggOSAwIFIKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3Ry
ZWFtCnic3Z1NjyXHcbX3/Svu+gU0rIz8LMAwINGSAS8MCBzgXRheGBRsQSANE1r477syqyrOE83u
4cxwqBmRhMTbp7PjZkVFZGZEnIr66p+/+Y/Hf/318dXX3/zP49vrv19/87S9adv1z2P++5sIlLE9
vv3+6YfHD09/fPrj8f/3f+cvv39KW+vHh+/OD2ObHzf/7/z/Pz/9///3+O/1Z+f/0pt2/bO+79mP
x3cdE7Be6rYfX/3sc8kpd6vl8c3X/3qMqz7R/32kx78c//vL498Ip8e/b4/Hn556ucFH2fbr8zH9
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
dl6o3CtxgRK3IoWNXNyKlHrEXX6jfLlXqsQ9qkpnUUhp/JQKNejhVEqZFzoHGm+B3Ittl6tIFQd+
AX7JmyS2OYJlnQNwXW7XCL/IbYS/dIkb9p8mNkXaoJSJu+Cma21iUyQeSZrYFGkrMpomNkXacHJt
YlNM3Dj+1qU+nrjLN87Hg6u0pYjfKt02ztO9bL9t7MTLBM55nBPx4Mpv7zXwlrZeYNZ0tfsdjZzj
PKhy+90v/JZbn+GXYvf6TM4tv4Tx7l2+EGwXfil2v0/J9/hbvj2Tcyl2v48PpxyPrfYUrt+9a7+P
kjd+K3YLehyPETXtbjXuvtfXwFux3tv5Hn8pwE98J74AfpMHVX4EvAa64Bau0J1sVI5XPXWEOyFP
HOFOiFOxCIFNXIoR7oC4FCPzwlXodc7rduGXRv2Md4+/5Sdej7gUfti88fv6t2fjb/nnz/nhHaIv
4L7gPsKFuG/9CL8U6nHBxL952h7z32++/ten9Pjfhz3+5fjfXx7/9u/b4/Gnpz8+/fB0LCrXP2vk
sx+//f7dEuIv0/HLpF/6k3LbozX/+D3xEpZUtSJ6DYec716R/93Tn3/edU8K8Mjzn0erP6mBL1XW
D09fff3N/zy+/evjHPbXb//76at//uY/Hv/116ffvX366g9HAFofb//zuGHz1785//P2lPr2T49/
2Lb0+398vP3LU3mzH+F6n3zC+zdbXr85TLCP40iD36Q/rN/0F/7mt6/9zTZe/c2r3/O6NNtenXVa
v5mHuq3Fv0mvfs+rf/NROnj9esr6ze/fHkZw/Pv44biB77aVxx+f/g8VprukCmVuZHN0cmVhbQpl
bmRvYmoKOSAwIG9iagoxMTc4MwplbmRvYmoKMTIgMCBvYmoKPDwgL1R5cGUgL0ZvbnREZXNjcmlw
dG9yCi9Gb250TmFtZSAvUU1BQUFBK05vdG9TYW5zLVJlZ3VsYXIKL0ZsYWdzIDQgCi9Gb250QkJv
eCBbLTYyMSAtMzg5IDI4MDAgMTA2NyBdCi9JdGFsaWNBbmdsZSAwIAovQXNjZW50IDEwNjkgCi9E
ZXNjZW50IC0yOTMgCi9DYXBIZWlnaHQgMTA2OSAKL1N0ZW1WIDUwIAovRm9udEZpbGUyIDEzIDAg
UgovQ0lEU2V0IDE2IDAgUgo+PgplbmRvYmoKMTMgMCBvYmoKPDwKL0xlbmd0aDEgNjQ0MCAKL0xl
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
3nYwTx3Mgz68u1Cum8l04ZiP6fvhjJUxK+g6g5h3+qSUzWxjvrcx3kucPyhZxLJK80y9qkHOgXO/
O0pzrSYtOEP9A/Ndc+YH5Pmrmc4+5KTo1DJvnZgNH3qexjAVwBWy8dtFT3awIw3XeOhdGkr7cCU9
8m6U1ct6fUj98OzuR2x7uIIfx/rRUoqXGoYIGmkzkw8wnNHoBnAVB7N5JhcevDuZD345Cv1Iuxj6
qK/tTLYaPbXjvYJp9c5Z2T5nhdUsEnOxSxG5hlXd32OZi90DrMJbGNIl+6Q1Hewaj3VczfJQjbSa
FDCectSOOqRqcJepIJvxTvl8RGYVXsuRLyXFbG4FjqgRYxU4WsRmlDJaemZmvaIc9yc1seETKkPX
dqNVUnT6GDeAkeljOPEzG/uYH904SiMs9RLqq5t5+PfHVY0x8s3JiZ/NcaJUK5OUKtfL6s7BEEXt
7GEWdrNYzmTEL8fPJee/m/lCq/7hc4rT7Wyud7bCBhmy+xhGJJukig38DVl9tB78aDHNbA/rvGnM
Ng/eqY9t+JxG3o4reNhIB4uNHy3oRiz4cLSG2eyZtY3284Bsr4NRfoaLh55a58Rw7uwZGYe8KziR
6mEa3cxqSc6PWpxyTmbQWMK8c7P+VY0o6mDV6WBrueZ4Obcn1jEESTtPjdzBixFFUl+0zz57SM2d
X8b0dyDfzVBFc1jAIuOavT9c7+ETqUd1of4O5GnmClnOXN/pAd8fmdHw/SflLKLdLHKFcvapRr+8
H9H4+OR89KK1btyZali9BLCSOhiKqU2DhPw/4MZflAplbmRzdHJlYW0KZW5kb2JqCjE3IDAgb2Jq
CjQyMDYKZW5kb2JqCjE0IDAgb2JqCjw8IC9UeXBlIC9Gb250Ci9TdWJ0eXBlIC9DSURGb250VHlw
ZTIKL0Jhc2VGb250IC9Ob3RvU2Fucy1SZWd1bGFyCi9DSURTeXN0ZW1JbmZvIDw8IC9SZWdpc3Ry
eSAoQWRvYmUpIC9PcmRlcmluZyAoSWRlbnRpdHkpIC9TdXBwbGVtZW50IDAgPj4KL0ZvbnREZXNj
cmlwdG9yIDEyIDAgUgovQ0lEVG9HSURNYXAgL0lkZW50aXR5Ci9XIFswIFs2MDAgMjYwIF0KMiAx
MSA1NzIgCjEyIFs5MDcgNTY0IDU2MSA2MTggNTY2IDcyOCAyNTggNDgwIDYwNSA2MTUgMjI1IDYx
NSAzMjIgMzYxIDQ3OSAyNjggNDQ0IDI1OCAzMjkgNTI5IDMyOSA1NzIgXQpdCj4+CmVuZG9iagox
NSAwIG9iago8PCAvTGVuZ3RoIDU5NSA+PgpzdHJlYW0KL0NJREluaXQgL1Byb2NTZXQgZmluZHJl
c291cmNlIGJlZ2luCjEyIGRpY3QgYmVnaW4KYmVnaW5jbWFwCi9DSURTeXN0ZW1JbmZvIDw8IC9S
ZWdpc3RyeSAoQWRvYmUpIC9PcmRlcmluZyAoVUNTKSAvU3VwcGxlbWVudCAwID4+IGRlZgovQ01h
cE5hbWUgL0Fkb2JlLUlkZW50aXR5LVVDUyBkZWYKL0NNYXBUeXBlIDIgZGVmCjEgYmVnaW5jb2Rl
c3BhY2VyYW5nZQo8MDAwMD4gPEZGRkY+CmVuZGNvZGVzcGFjZXJhbmdlCjIgYmVnaW5iZnJhbmdl
CjwwMDAwPiA8MDAwMD4gPDAwMDA+CjwwMDAxPiA8MDAyMT4gWzwwMDA5PiA8MDAzMj4gPDAwMzA+
IDwwMDM0PiA8MDAzNj4gPDAwMzg+IDwwMDMxPiA8MDAzNT4gPDAwMzc+IDwwMDMzPiA8MDAzOT4g
PDAwNEQ+IDwwMDY1PiA8MDA2MT4gPDAwNkU+IDwwMDU5PiA8MDA0Nz4gPDAwNjk+IDwwMDYzPiA8
MDA2Rj4gPDAwNjQ+IDwwMDI3PiA8MDA2Nz4gPDAwMkQ+IDwwMDc0PiA8MDA3Mz4gPDAwMkU+IDww
MDVGPiA8MDA2Qz4gPDAwNUI+IDwwMDc4PiA8MDA1RD4gPDAwM0Q+IF0KZW5kYmZyYW5nZQplbmRj
bWFwCkNNYXBOYW1lIGN1cnJlbnRkaWN0IC9DTWFwIGRlZmluZXJlc291cmNlIHBvcAplbmQKZW5k
CgplbmRzdHJlYW0KZW5kb2JqCjcgMCBvYmoKPDwgL1R5cGUgL0ZvbnQKL1N1YnR5cGUgL1R5cGUw
Ci9CYXNlRm9udCAvTm90b1NhbnMtUmVndWxhcgovRW5jb2RpbmcgL0lkZW50aXR5LUgKL0Rlc2Nl
bmRhbnRGb250cyBbMTQgMCBSXQovVG9Vbmljb2RlIDE1IDAgUj4+CmVuZG9iagoxNiAwIG9iago8
PAovTGVuZ3RoIDUKPj4Kc3RyZWFtCv/////ACmVuZHN0cmVhbQplbmRvYmoKMyAwIG9iago8PAov
VHlwZSAvUGFnZXMKL0tpZHMgClsKNiAwIFIKXQovQ291bnQgMQovUHJvY1NldCBbL1BERiAvVGV4
dCAvSW1hZ2VCIC9JbWFnZUNdCj4+CmVuZG9iagp4cmVmCjAgMTgKMDAwMDAwMDAwMCA2NTUzNSBm
IAowMDAwMDAwMDE1IDAwMDAwIG4gCjAwMDAwMDAxMzEgMDAwMDAgbiAKMDAwMDAxODIyOCAwMDAw
MCBuIAowMDAwMDAwMTgwIDAwMDAwIG4gCjAwMDAwMDAyNzUgMDAwMDAgbiAKMDAwMDAwMDMxMiAw
MDAwMCBuIAowMDAwMDE4MDMxIDAwMDAwIG4gCjAwMDAwMDA2MzIgMDAwMDAgbiAKMDAwMDAxMjQ4
OSAwMDAwMCBuIAowMDAwMDAwNDQ2IDAwMDAwIG4gCjAwMDAwMDA2MTIgMDAwMDAgbiAKMDAwMDAx
MjUxMCAwMDAwMCBuIAowMDAwMDEyNzM4IDAwMDAwIG4gCjAwMDAwMTcwNTYgMDAwMDAgbiAKMDAw
MDAxNzM4NCAwMDAwMCBuIAowMDAwMDE4MTczIDAwMDAwIG4gCjAwMDAwMTcwMzUgMDAwMDAgbiAK
dHJhaWxlcgo8PAovU2l6ZSAxOCAKL0luZm8gMSAwIFIKL1Jvb3QgMiAwIFIKPj4Kc3RhcnR4cmVm
CjE4MzI2IAolJUVPRgo=
--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=gain-test.3503_00.log

16 19.18
17 19.21
18 19.24
19 19.28
20 19.31
21 19.34
22 19.36
23 19.38
24 19.38
25 19.41
26 19.46
27 19.48
28 19.51
29 19.53
30 19.57
31 19.58
32 19.63
33 19.66
34 19.70
35 19.75
36 19.77
37 19.81
38 19.83
39 19.90
40 19.94
41 19.96
42 19.98
43 20.04
44 20.06
45 20.11
46 20.13
47 20.17
48 20.23
49 20.26
50 20.29
51 20.34
52 20.38
53 20.43
54 20.47
55 20.54
56 20.58
57 20.63
58 20.68
59 20.73
60 20.77
61 20.83
62 20.87
63 20.95
64 21.02
65 21.06
66 21.10
67 21.15
68 21.22
69 21.27
70 21.33
71 21.38
72 21.44
73 21.50
74 21.65
75 21.62
76 21.67
77 21.78
78 21.83
79 21.89
80 21.95
81 22.00
82 22.06
83 22.12
84 22.19
85 22.24
86 22.31
87 22.37
88 22.44
89 22.51
90 22.58
91 22.63
92 22.70
93 22.77
94 22.83
95 22.89
96 23.00
97 23.05
98 23.12
99 23.18
100 23.25
101 23.31
102 23.38
103 23.45
104 23.52
105 23.60
106 23.67
107 23.73
108 23.80
109 23.87
110 23.94
111 24.00
112 24.08
113 24.14
114 24.21
115 24.28
116 24.35
117 24.42
118 24.49
119 24.56
120 24.64
121 24.71
122 24.77
123 24.85
124 24.92
125 24.99
126 25.06
127 25.11
128 20.73
129 21.03
130 20.95
131 20.86
132 20.90
133 21.19
134 20.98
135 21.02
136 21.32
137 21.37
138 21.35
139 21.21
140 21.27
141 21.56
142 21.61
143 21.41
144 21.71
145 21.78
146 21.67
147 21.84
148 21.89
149 21.79
150 22.07
151 21.92
152 22.21
153 22.05
154 22.35
155 22.41
156 22.26
157 22.57
158 22.56
159 22.47
160 22.56
161 22.81
162 22.72
163 22.79
164 23.09
165 23.05
166 23.18
167 23.26
168 23.19
169 23.28
170 23.37
171 23.44
172 23.53
173 23.62
174 23.70
175 23.79
176 23.88
177 23.96
178 24.04
179 24.13
180 24.22
181 24.34
182 24.41
183 24.49
184 24.59
185 24.69
186 24.78
187 24.87
188 24.96
189 25.06
190 25.14
191 25.23
192 25.34
193 25.44
194 25.54
195 25.63
196 25.72
197 25.83
198 25.93
199 26.02
200 26.13
201 26.23
202 26.32
203 26.42
204 26.51
205 26.62
206 26.91
207 26.81
208 26.91
209 27.02
210 27.12
211 27.21
212 27.30
213 27.41
214 27.50
215 27.60
216 27.71
217 27.81
218 27.91
219 28.01
220 28.10
221 28.21
222 28.30
223 28.39
224 28.49
225 28.59
226 28.69
227 28.79
228 28.89
229 28.99
230 29.08
231 29.18
232 29.29
233 29.39
234 29.49
235 29.58
236 29.68
237 29.78
238 29.87
239 29.96
240 30.07
241 30.17
242 30.27
243 30.37
244 30.46
245 30.56
246 30.66
247 30.75
248 30.85
249 30.96
250 31.05
251 31.15
252 31.24
253 31.35
254 31.44
255 31.54
256 22.33
257 22.33
258 22.40
259 22.40
260 22.47
261 22.47
262 22.54
263 22.54
264 22.61
265 22.62
266 22.71
267 22.71
268 22.79
269 22.79
270 22.87
271 22.87
272 22.99
273 22.99
274 23.08
275 23.08
276 23.18
277 23.18
278 23.27
279 23.27
280 23.37
281 23.38
282 23.50
283 23.50
284 23.60
285 23.60
286 23.72
287 23.72
288 23.86
289 23.86
290 23.99
291 23.99
292 24.11
293 24.11
294 24.24
295 24.24
296 24.38
297 24.38
298 24.53
299 24.52
300 24.67
301 24.67
302 24.81
303 24.81
304 24.97
305 24.97
306 25.12
307 25.12
308 25.27
309 25.27
310 25.42
311 25.42
312 25.58
313 25.58
314 25.76
315 25.76
316 25.91
317 25.91
318 26.07
319 25.99
320 26.25
321 26.25
322 26.43
323 26.43
324 26.60
325 26.60
326 26.77
327 26.77
328 26.87
329 26.94
330 27.12
331 27.13
332 27.27
333 27.22
334 27.47
335 27.47
336 27.67
337 27.67
338 27.86
339 27.86
340 28.03
341 28.03
342 28.20
343 28.20
344 28.37
345 28.37
346 28.56
347 28.56
348 28.74
349 28.75
350 28.93
351 28.93
352 29.13
353 29.13
354 29.33
355 29.33
356 29.51
357 29.51
358 29.70
359 29.69
360 29.88
361 29.88
362 30.09
363 30.09
364 30.28
365 30.27
366 30.46
367 30.46
368 30.66
369 30.65
370 30.86
371 30.86
372 30.97
373 30.98
374 31.17
375 31.24
376 31.44
377 31.44
378 31.56
379 31.65
380 31.83
381 31.83
382 32.03
383 32.03
384 32.26
385 32.26
386 32.47
387 32.47
388 32.62
389 32.67
390 32.86
391 32.86
392 33.06
393 33.05
394 33.27
395 33.27
396 33.47
397 33.47
398 33.67
399 33.59
400 33.88
401 33.88
402 34.07
403 34.01
404 34.22
405 34.21
406 34.48
407 34.49
408 34.68
409 34.68
410 34.81
411 34.81
412 35.00
413 35.09
414 35.28
415 35.07
416 35.50
417 35.29
418 35.57
419 35.72
420 35.93
421 35.85
422 36.13
423 35.91
424 36.30
425 36.12
426 36.46
427 36.33
428 36.67
429 36.67
430 36.94
431 36.73
432 37.07
433 37.07
434 37.28
435 37.22
436 37.35
437 37.35
438 37.76
439 37.55
440 37.87
441 37.74
442 38.02
443 38.02
444 38.29
445 38.29
446 38.36
447 38.36
448 38.57
449 38.57
450 38.79
451 38.79
452 38.99
453 38.99
454 39.19
455 39.19
456 39.39
457 39.39
458 39.60
459 39.60
460 39.80
461 39.80
462 39.99
463 40.00
464 40.21
465 40.21
466 40.49
467 40.42
468 40.63
469 40.63
470 40.83
471 40.83
472 41.03
473 41.03
474 41.25
475 41.24
476 41.44
477 41.44
478 41.64
479 41.64
480 41.85
481 41.85
482 42.06
483 42.06
484 42.27
485 42.27
486 42.46
487 42.46
488 42.66
489 42.66
490 42.88
491 42.88
492 43.08
493 43.08
494 43.28
495 43.28
496 43.49
497 43.48
498 43.70
499 43.70
500 43.90
501 43.90
502 44.10
503 44.10
504 44.29
505 44.29
506 44.51
507 44.50
508 44.70
509 44.71
510 44.90
511 44.90
512 24.07
513 24.07
514 24.07
515 24.07
516 24.22
517 24.21
518 24.21
519 24.21
520 24.36
521 24.36
522 24.36
523 24.36
524 24.51
525 24.51
526 24.51
527 24.51
528 24.68
529 24.68
530 24.68
531 24.68
532 24.86
533 24.86
534 24.86
535 24.86
536 25.04
537 25.05
538 25.04
539 25.04
540 25.25
541 25.25
542 25.25
543 25.25
544 25.50
545 25.50
546 25.50
547 25.50
548 25.75
549 25.75
550 25.75
551 25.75
552 25.97
553 25.97
554 25.97
555 25.97
556 26.21
557 26.21
558 26.21
559 26.14
560 26.46
561 26.46
562 26.46
563 26.46
564 26.75
565 26.68
566 26.75
567 26.75
568 27.02
569 27.02
570 27.02
571 27.02
572 27.31
573 27.31
574 27.31
575 27.24
576 27.57
577 27.43
578 27.43
579 27.64
580 27.96
581 27.96
582 27.96
583 27.96
584 28.27
585 28.28
586 28.27
587 28.27
588 28.59
589 28.38
590 28.59
591 28.59
592 28.92
593 28.85
594 28.92
595 28.92
596 29.28
597 29.28
598 29.28
599 29.23
600 29.62
601 29.40
602 29.40
603 29.54
604 29.96
605 29.96
606 29.96
607 29.96
608 30.34
609 30.34
610 30.34
611 30.34
612 30.73
613 30.65
614 30.73
615 30.73
616 31.03
617 31.03
618 31.10
619 31.03
620 31.39
621 31.39
622 31.39
623 31.26
624 31.84
625 31.76
626 31.63
627 31.63
628 32.16
629 32.16
630 32.16
631 32.17
632 32.54
633 32.55
634 32.57
635 32.55
636 32.97
637 32.92
638 32.97
639 32.93
640 33.33
641 33.20
642 33.20
643 33.21
644 33.75
645 33.75
646 33.75
647 33.76
648 34.02
649 34.02
650 34.23
651 34.16
652 34.48
653 34.55
654 34.41
655 34.63
656 34.94
657 34.94
658 34.94
659 35.03
660 35.38
661 35.37
662 35.37
663 35.44
664 35.78
665 35.65
666 35.65
667 35.66
668 36.11
669 36.05
670 36.18
671 36.06
672 36.55
673 36.48
674 36.49
675 36.63
676 36.98
677 37.05
678 36.91
679 36.92
680 37.33
681 37.46
682 37.33
683 37.35
684 37.72
685 37.86
686 37.73
687 37.80
688 38.26
689 38.13
690 38.13
691 38.14
692 38.78
693 38.69
694 38.56
695 38.64
696 38.97
697 38.97
698 38.97
699 39.05
700 39.37
701 39.37
702 39.37
703 39.39
704 40.01
705 39.80
706 39.93
707 39.81
708 40.23
709 40.24
710 40.24
711 40.25
712 40.79
713 40.66
714 40.66
715 40.78
716 41.20
717 41.28
718 41.20
719 41.16
720 41.61
721 41.61
722 41.62
723 41.63
724 42.05
725 42.05
726 42.06
727 41.94
728 42.53
729 42.47
730 42.34
731 42.49
732 42.88
733 42.75
734 42.89
735 42.98
736 43.25
737 43.31
738 43.19
739 43.34
740 43.63
741 43.63
742 43.77
743 43.65
744 44.19
745 44.06
746 44.20
747 44.30
748 44.46
749 44.46
750 44.60
751 44.48
752 44.93
753 45.00
754 45.00
755 45.02
756 45.45
757 45.31
758 45.32
759 45.47
760 45.86
761 45.73
762 45.74
763 45.89
764 46.27
765 46.20
766 46.15
767 46.17
768 46.62
769 46.68
770 46.62
771 46.65
772 47.07
773 47.07
774 47.08
775 47.11
776 47.51
777 47.51
778 47.64
779 47.54
780 47.92
781 47.92
782 47.93
783 48.09
784 48.33
785 48.34
786 48.34
787 48.37
788 48.91
789 48.78
790 48.79
791 48.82
792 49.21
793 49.21
794 49.22
795 49.25
796 49.61
797 49.62
798 49.63
799 49.66
800 50.06
801 50.06
802 49.99
803 50.11
804 50.51
805 50.51
806 50.44
807 50.56
808 50.95
809 50.95
810 50.96
811 50.99
812 51.37
813 51.37
814 51.38
815 51.42
816 51.78
817 51.78
818 51.80
819 51.83
820 52.23
821 52.23
822 52.24
823 52.18
824 52.56
825 52.62
826 52.67
827 52.68
828 53.06
829 52.97
830 52.98
831 53.10
832 53.42
833 53.50
834 53.52
835 53.55
836 53.95
837 53.87
838 53.88
839 54.00
840 54.39
841 54.39
842 54.32
843 54.37
844 54.71
845 54.71
846 54.73
847 54.85
848 55.13
849 55.06
850 55.14
851 55.26
852 55.67
853 55.51
854 55.68
855 55.71
856 56.00
857 56.00
858 56.02
859 56.05
860 56.28
861 56.41
862 56.43
863 56.46
864 56.84
865 56.84
866 56.86
867 56.90
868 57.29
869 57.29
870 57.25
871 57.34
872 57.72
873 57.72
874 57.80
875 57.78
876 58.13
877 58.13
878 58.15
879 58.19
880 58.54
881 58.54
882 58.57
883 58.60
884 58.86
885 58.93
886 59.01
887 59.06
888 59.41
889 59.41
890 59.44
891 59.47
892 59.69
893 59.69
894 59.72
895 59.76
896 60.12
897 60.26
898 60.15
899 60.31
900 60.71
901 60.70
902 60.60
903 60.77
904 61.07
905 61.13
906 61.16
907 61.14
908 61.42
909 61.55
910 61.45
911 61.55
912 61.90
913 61.96
914 61.97
915 61.91
916 62.40
917 62.28
918 62.43
919 62.47
920 62.70
921 62.83
922 62.84
923 62.89
924 63.24
925 63.11
926 63.12
927 63.30
928 63.55
929 63.55
930 63.70
931 63.62
932 64.13
933 64.12
934 64.01
935 64.06
936 64.43
937 64.43
938 64.45
939 64.50
940 64.83
941 64.84
942 64.86
943 64.91
944 65.37
945 65.32
946 65.27
947 65.45
948 65.69
949 65.69
950 65.87
951 65.88
952 66.10
953 66.10
954 66.12
955 66.29
956 66.51
957 66.51
958 66.53
959 66.57
960 66.93
961 66.93
962 67.02
963 66.99
964 67.37
965 67.50
966 67.40
967 67.44
968 67.80
969 67.80
970 67.83
971 68.00
972 68.21
973 68.28
974 68.24
975 68.28
976 68.63
977 68.76
978 68.65
979 68.82
980 69.21
981 69.07
982 69.23
983 69.15
984 69.49
985 69.47
986 69.52
987 69.69
988 69.91
989 69.90
990 69.93
991 69.98
992 70.33
993 70.33
994 70.36
995 70.40
996 70.77
997 70.79
998 70.78
999 70.85
1000 71.20
1001 71.20
1002 71.23
1003 71.27
1004 71.61
1005 71.52
1006 71.54
1007 71.67
1008 72.01
1009 72.02
1010 72.04
1011 72.08
1012 72.45
1013 72.57
1014 72.48
1015 72.52
1016 72.86
1017 72.99
1018 72.80
1019 72.93
1020 73.19
1021 73.27
1022 73.29
1023 73.35
1024 26.32
1025 26.54
1026 26.54
1027 26.47
1028 26.43
1029 26.48
1030 26.49
1031 26.54
1032 26.87
1033 26.87
1034 26.87
1035 26.87
1036 26.77
1037 26.77
1038 26.88
1039 26.81
1040 27.20
1041 27.21
1042 27.14
1043 27.21
1044 27.14
1045 27.14
1046 27.21
1047 27.21
1048 27.42
1049 27.50
1050 27.57
1051 27.50
1052 27.36
1053 27.57
1054 27.57
1055 27.53
1056 27.89
1057 27.89
1058 27.96
1059 27.75
1060 27.89
1061 27.89
1062 27.78
1063 27.89
1064 28.19
1065 28.33
1066 28.41
1067 28.33
1068 28.19
1069 28.41
1070 28.41
1071 28.41
1072 28.75
1073 28.80
1074 28.83
1075 28.75
1076 28.83
1077 28.78
1078 28.61
1079 28.61
1080 29.28
1081 29.28
1082 29.28
1083 29.20
1084 29.17
1085 29.21
1086 29.21
1087 29.29
1088 29.76
1089 29.76
1090 29.76
1091 29.76
1092 29.76
1093 29.76
1094 29.63
1095 29.76
1096 30.39
1097 30.39
1098 30.39
1099 30.39
1100 30.32
1101 30.32
1102 30.39
1103 30.40
1104 30.94
1105 30.86
1106 30.72
1107 30.86
1108 30.82
1109 30.82
1110 30.72
1111 30.73
1112 31.41
1113 31.41
1114 31.41
1115 31.28
1116 31.28
1117 31.41
1118 31.28
1119 31.29
1120 32.06
1121 31.99
1122 31.85
1123 31.99
1124 31.85
1125 31.85
1126 31.99
1127 31.93
1128 32.63
1129 32.71
1130 32.63
1131 32.68
1132 32.56
1133 32.71
1134 32.71
1135 32.64
1136 33.20
1137 33.17
1138 33.24
1139 33.10
1140 33.20
1141 33.11
1142 33.25
1143 33.25
1144 33.87
1145 33.89
1146 33.73
1147 33.86
1148 33.86
1149 33.87
1150 33.96
1151 33.75
1152 34.53
1153 34.60
1154 34.60
1155 34.60
1156 34.46
1157 34.47
1158 34.61
1159 34.62
1160 35.32
1161 35.19
1162 35.26
1163 35.32
1164 35.32
1165 35.29
1166 35.21
1167 35.42
1168 36.08
1169 36.03
1170 35.89
1171 35.89
1172 36.03
1173 35.90
1174 35.98
1175 36.05
1176 36.80
1177 36.59
1178 36.72
1179 36.59
1180 36.60
1181 36.60
1182 36.61
1183 36.62
1184 37.29
1185 37.30
1186 37.43
1187 37.29
1188 37.43
1189 37.44
1190 37.44
1191 37.46
1192 38.20
1193 38.19
1194 38.13
1195 38.06
1196 38.26
1197 38.08
1198 38.22
1199 38.23
1200 38.79
1201 38.93
1202 38.79
1203 39.00
1204 38.93
1205 38.81
1206 38.94
1207 38.90
1208 39.52
1209 39.52
1210 39.52
1211 39.52
1212 39.66
1213 39.72
1214 39.67
1215 39.56
1216 40.52
1217 40.44
1218 40.44
1219 40.44
1220 40.53
1221 40.32
1222 40.47
1223 40.48
1224 41.11
1225 41.25
1226 41.11
1227 41.12
1228 41.26
1229 41.35
1230 41.28
1231 41.38
1232 42.03
1233 42.03
1234 42.03
1235 41.90
1236 42.04
1237 41.92
1238 42.07
1239 42.09
1240 42.80
1241 42.80
1242 42.67
1243 42.80
1244 42.68
1245 42.82
1246 42.83
1247 42.85
1248 43.43
1249 43.56
1250 43.50
1251 43.56
1252 43.58
1253 43.58
1254 43.48
1255 43.48
1256 44.27
1257 44.27
1258 44.27
1259 44.27
1260 44.41
1261 44.29
1262 44.31
1263 44.32
1264 45.18
1265 45.05
1266 45.05
1267 45.12
1268 45.19
1269 45.21
1270 45.10
1271 45.18
1272 45.96
1273 45.82
1274 45.96
1275 45.96
1276 45.83
1277 45.86
1278 45.87
1279 45.88
1280 46.69
1281 46.82
1282 46.69
1283 46.70
1284 46.70
1285 46.72
1286 46.75
1287 46.88
1288 47.55
1289 47.56
1290 47.68
1291 47.56
1292 47.57
1293 47.59
1294 47.62
1295 47.62
1296 48.38
1297 48.38
1298 48.38
1299 48.52
1300 48.40
1301 48.55
1302 48.43
1303 48.46
1304 49.17
1305 49.18
1306 49.17
1307 49.19
1308 49.20
1309 49.22
1310 49.23
1311 49.25
1312 49.88
1313 49.97
1314 49.97
1315 49.98
1316 49.99
1317 50.02
1318 50.03
1319 50.05
1320 50.82
1321 50.84
1322 50.84
1323 50.85
1324 50.86
1325 50.86
1326 50.90
1327 50.93
1328 51.66
1329 51.66
1330 51.67
1331 51.59
1332 51.69
1333 51.72
1334 51.72
1335 51.75
1336 52.39
1337 52.47
1338 52.47
1339 52.49
1340 52.44
1341 52.53
1342 52.54
1343 52.48
1344 53.28
1345 53.37
1346 53.37
1347 53.30
1348 53.40
1349 53.34
1350 53.43
1351 53.47
1352 54.25
1353 54.16
1354 54.25
1355 54.18
1356 54.27
1357 54.22
1358 54.32
1359 54.26
1360 55.09
1361 55.00
1362 55.00
1363 55.03
1364 55.03
1365 55.06
1366 55.08
1367 55.11
1368 55.80
1369 55.90
1370 55.90
1371 55.82
1372 55.91
1373 55.86
1374 55.88
1375 55.90
1376 56.61
1377 56.62
1378 56.62
1379 56.63
1380 56.65
1381 56.76
1382 56.70
1383 56.71
1384 57.49
1385 57.49
1386 57.49
1387 57.37
1388 57.53
1389 57.55
1390 57.58
1391 57.47
1392 58.25
1393 58.32
1394 58.32
1395 58.32
1396 58.37
1397 58.46
1398 58.40
1399 58.43
1400 59.00
1401 59.00
1402 59.13
1403 59.14
1404 59.04
1405 59.18
1406 59.16
1407 59.23
1408 59.98
1409 59.99
1410 59.98
1411 59.93
1412 59.97
1413 60.04
1414 60.07
1415 60.10
1416 60.87
1417 60.74
1418 60.88
1419 60.88
1420 60.86
1421 60.81
1422 60.97
1423 60.99
1424 61.72
1425 61.60
1426 61.73
1427 61.61
1428 61.64
1429 61.66
1430 61.82
1431 61.84
1432 62.42
1433 62.41
1434 62.41
1435 62.43
1436 62.46
1437 62.48
1438 62.64
1439 62.66
1440 63.22
1441 63.23
1442 63.36
1443 63.24
1444 63.41
1445 63.30
1446 63.33
1447 63.35
1448 64.12
1449 64.11
1450 64.12
1451 64.14
1452 64.29
1453 64.18
1454 64.21
1455 64.24
1456 64.91
1457 64.94
1458 64.94
1459 65.08
1460 65.13
1461 65.01
1462 65.16
1463 65.07
1464 65.81
1465 65.75
1466 65.75
1467 65.76
1468 65.80
1469 65.82
1470 65.84
1471 65.88
1472 66.60
1473 66.59
1474 66.60
1475 66.75
1476 66.66
1477 66.67
1478 66.69
1479 66.74
1480 67.48
1481 67.47
1482 67.48
1483 67.50
1484 67.53
1485 67.56
1486 67.55
1487 67.62
1488 68.39
1489 68.32
1490 68.33
1491 68.34
1492 68.38
1493 68.39
1494 68.42
1495 68.47
1496 69.04
1497 69.13
1498 69.05
1499 69.15
1500 69.09
1501 69.34
1502 69.15
1503 69.29
1504 69.92
1505 69.94
1506 69.95
1507 69.92
1508 70.12
1509 69.94
1510 69.97
1511 70.01
1512 70.81
1513 70.79
1514 70.83
1515 70.85
1516 70.87
1517 70.91
1518 70.94
1519 70.87
1520 71.62
1521 71.64
1522 71.58
1523 71.67
1524 71.69
1525 71.73
1526 71.66
1527 71.78
1528 72.44
1529 72.42
1530 72.46
1531 72.47
1532 72.50
1533 72.54
1534 72.57
1535 72.57
1536 73.40
1537 73.39
1538 73.31
1539 73.33
1540 73.36
1541 73.49
1542 73.51
1543 73.52
1544 74.27
1545 74.26
1546 74.20
1547 74.29
1548 74.32
1549 74.30
1550 74.39
1551 74.33
1552 75.09
1553 75.01
1554 75.11
1555 75.05
1556 75.07
1557 75.11
1558 75.22
1559 75.26
1560 75.80
1561 75.90
1562 75.90
1563 75.92
1564 75.86
1565 75.90
1566 75.94
1567 75.95
1568 76.59
1569 76.67
1570 76.60
1571 76.62
1572 76.64
1573 76.69
1574 76.78
1575 76.74
1576 77.51
1577 77.50
1578 77.55
1579 77.47
1580 77.50
1581 77.52
1582 77.57
1583 77.60
1584 78.23
1585 78.23
1586 78.25
1587 78.26
1588 78.31
1589 78.30
1590 78.35
1591 78.38
1592 78.99
1593 78.98
1594 79.00
1595 79.02
1596 79.04
1597 79.06
1598 79.13
1599 79.15
1600 79.83
1601 79.83
1602 79.84
1603 79.96
1604 79.89
1605 79.91
1606 79.96
1607 79.99
1608 80.65
1609 80.65
1610 80.72
1611 80.68
1612 80.70
1613 80.73
1614 80.78
1615 80.75
1616 81.41
1617 81.41
1618 81.44
1619 81.46
1620 81.48
1621 81.52
1622 81.56
1623 81.58
1624 82.17
1625 82.15
1626 82.17
1627 82.20
1628 82.22
1629 82.25
1630 82.30
1631 82.32
1632 82.91
1633 82.89
1634 82.91
1635 82.94
1636 82.96
1637 82.98
1638 83.04
1639 83.07
1640 83.69
1641 83.68
1642 83.77
1643 83.73
1644 83.76
1645 83.77
1646 83.80
1647 83.87
1648 84.42
1649 84.43
1650 84.43
1651 84.47
1652 84.58
1653 84.51
1654 84.54
1655 84.59
1656 85.08
1657 85.15
1658 85.15
1659 85.19
1660 85.21
1661 85.24
1662 85.27
1663 85.32
1664 85.94
1665 85.94
1666 85.93
1667 85.98
1668 86.01
1669 86.02
1670 86.15
1671 85.98
1672 86.71
1673 86.72
1674 86.72
1675 86.76
1676 86.67
1677 86.81
1678 86.84
1679 86.91
1680 87.44
1681 87.45
1682 87.45
1683 87.50
1684 87.52
1685 87.49
1686 87.57
1687 87.64
1688 88.09
1689 88.15
1690 88.16
1691 88.20
1692 88.22
1693 88.26
1694 88.22
1695 88.31
1696 88.85
1697 88.85
1698 88.94
1699 88.69
1700 88.92
1701 88.95
1702 88.97
1703 89.01
1704 89.60
1705 89.48
1706 89.48
1707 89.65
1708 89.67
1709 89.70
1710 89.74
1711 89.71
1712 90.30
1713 90.24
1714 90.31
1715 90.35
1716 90.26
1717 90.40
1718 90.31
1719 90.46
1720 90.99
1721 90.93
1722 90.99
1723 91.04
1724 91.06
1725 90.96
1726 91.12
1727 91.14
1728 91.69
1729 91.70
1730 91.57
1731 91.74
1732 91.77
1733 91.74
1734 91.83
1735 91.85
1736 92.42
1737 92.42
1738 92.30
1739 92.47
1740 92.49
1741 92.52
1742 92.43
1743 92.58
1744 93.06
1745 92.97
1746 93.05
1747 93.04
1748 93.19
1749 93.23
1750 93.25
1751 93.28
1752 93.80
1753 93.78
1754 93.78
1755 93.84
1756 93.79
1757 93.77
1758 93.93
1759 93.94
1760 94.45
1761 94.44
1762 94.44
1763 94.36
1764 94.40
1765 94.55
1766 94.58
1767 94.61
1768 95.03
1769 95.04
1770 95.15
1771 94.98
1772 95.20
1773 95.14
1774 95.16
1775 95.32
1776 95.81
1777 95.81
1778 95.82
1779 95.84
1780 95.78
1781 95.73
1782 95.95
1783 95.98
1784 96.46
1785 96.45
1786 96.46
1787 96.49
1788 96.53
1789 96.45
1790 96.59
1791 96.62
1792 97.03
1793 97.13
1794 97.14
1795 97.18
1796 97.22
1797 97.24
1798 97.16
1799 97.30
1800 97.72
1801 97.78
1802 97.71
1803 97.86
1804 97.71
1805 97.94
1806 97.98
1807 97.99
1808 98.29
1809 98.38
1810 98.50
1811 98.53
1812 98.58
1813 98.62
1814 98.73
1815 98.68
1816 99.13
1817 99.13
1818 99.14
1819 99.04
1820 99.21
1821 99.25
1822 99.28
1823 99.30
1824 99.64
1825 99.77
1826 99.57
1827 99.59
1828 99.62
1829 99.77
1830 99.80
1831 99.93
1832 100.44
1833 100.46
1834 100.45
1835 100.49
1836 100.50
1837 100.44
1838 100.60
1839 100.55
1840 101.07
1841 100.88
1842 101.08
1843 101.11
1844 101.13
1845 101.20
1846 101.22
1847 101.27
1848 101.70
1849 101.70
1850 101.69
1851 101.70
1852 101.63
1853 101.81
1854 101.81
1855 101.71
1856 102.36
1857 102.24
1858 102.38
1859 102.40
1860 102.41
1861 102.47
1862 102.44
1863 102.53
1864 103.02
1865 102.90
1866 102.82
1867 102.93
1868 103.08
1869 103.10
1870 103.17
1871 103.18
1872 103.44
1873 103.58
1874 103.64
1875 103.68
1876 103.67
1877 103.55
1878 103.73
1879 103.82
1880 104.04
1881 104.18
1882 104.13
1883 104.27
1884 104.30
1885 104.13
1886 104.38
1887 104.29
1888 104.71
1889 104.71
1890 104.80
1891 104.82
1892 104.83
1893 104.73
1894 104.98
1895 104.90
1896 105.27
1897 105.47
1898 105.47
1899 105.42
1900 105.45
1901 105.48
1902 105.58
1903 105.64
1904 105.95
1905 106.06
1906 105.99
1907 105.90
1908 105.96
1909 106.03
1910 106.05
1911 106.15
1912 106.57
1913 106.63
1914 106.43
1915 106.48
1916 106.61
1917 106.62
1918 106.55
1919 106.58
1920 107.13
1921 107.23
1922 107.09
1923 107.15
1924 107.21
1925 107.32
1926 107.23
1927 107.27
1928 107.66
1929 107.74
1930 107.66
1931 107.69
1932 107.80
1933 107.87
1934 107.77
1935 107.90
1936 108.43
1937 108.45
1938 108.32
1939 108.33
1940 108.46
1941 108.40
1942 108.56
1943 108.47
1944 108.81
1945 108.84
1946 109.00
1947 109.03
1948 108.86
1949 108.89
1950 109.12
1951 109.14
1952 109.38
1953 109.55
1954 109.42
1955 109.40
1956 109.41
1957 109.46
1958 109.48
1959 109.53
1960 110.15
1961 109.96
1962 109.96
1963 110.05
1964 110.06
1965 110.05
1966 110.08
1967 110.25
1968 110.51
1969 110.52
1970 110.52
1971 110.74
1972 110.76
1973 110.60
1974 110.82
1975 110.72
1976 111.05
1977 111.17
1978 111.05
1979 111.08
1980 111.11
1981 111.14
1982 111.17
1983 111.40
1984 111.61
1985 111.61
1986 111.61
1987 111.65
1988 111.67
1989 111.71
1990 111.75
1991 111.77
1992 112.20
1993 112.21
1994 112.19
1995 112.23
1996 112.25
1997 112.28
1998 112.50
1999 112.33
2000 112.73
2001 112.83
2002 112.74
2003 112.78
2004 112.81
2005 112.91
2006 112.85
2007 112.90
2008 113.25
2009 113.25
2010 113.26
2011 113.29
2012 113.31
2013 113.39
2014 113.37
2015 113.40
2016 113.77
2017 113.77
2018 113.77
2019 113.81
2020 113.82
2021 113.86
2022 113.88
2023 113.91
2024 114.32
2025 114.32
2026 114.31
2027 114.36
2028 114.39
2029 114.40
2030 114.43
2031 114.48
2032 114.93
2033 114.82
2034 114.84
2035 114.86
2036 114.88
2037 114.93
2038 114.94
2039 114.98
2040 115.34

--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=gain-test.3503_04.log

16 21.69
17 21.76
18 21.81
19 21.65
20 21.94
21 21.99
22 22.05
23 22.04
24 21.96
25 22.20
26 22.33
27 22.41
28 22.39
29 22.55
30 22.38
31 22.62
32 22.77
33 22.80
34 22.87
35 23.01
36 23.08
37 23.09
38 23.01
39 23.19
40 23.41
41 23.27
42 23.36
43 23.43
44 23.52
45 23.61
46 23.70
47 23.78
48 23.87
49 23.95
50 24.03
51 24.27
52 24.21
53 24.31
54 24.40
55 24.48
56 24.58
57 24.68
58 24.77
59 24.87
60 24.95
61 25.05
62 25.13
63 25.22
64 25.33
65 25.44
66 25.53
67 25.63
68 25.72
69 25.82
70 25.92
71 26.02
72 26.12
73 26.22
74 26.32
75 26.41
76 26.51
77 26.62
78 26.71
79 26.80
80 26.91
81 27.01
82 27.11
83 27.21
84 27.30
85 27.41
86 27.50
87 27.60
88 27.71
89 27.81
90 27.91
91 28.01
92 28.11
93 28.21
94 28.30
95 28.39
96 28.49
97 28.59
98 28.69
99 28.79
100 28.89
101 28.99
102 29.09
103 29.18
104 29.29
105 29.40
106 29.49
107 29.59
108 29.68
109 29.78
110 29.87
111 29.97
112 30.07
113 30.17
114 30.27
115 30.37
116 30.47
117 30.57
118 30.66
119 30.75
120 30.86
121 30.96
122 31.06
123 31.15
124 31.25
125 31.35
126 31.45
127 31.55
128 31.65
129 31.75
130 31.85
131 31.94
132 32.04
133 32.14
134 32.23
135 32.33
136 32.43
137 32.54
138 32.64
139 32.73
140 32.82
141 32.92
142 33.15
143 33.11
144 33.21
145 33.31
146 33.41
147 33.51
148 33.61
149 33.71
150 33.87
151 33.89
152 33.99
153 34.10
154 34.20
155 34.42
156 34.38
157 34.48
158 34.58
159 34.67
160 34.99
161 34.88
162 34.97
163 35.20
164 35.16
165 35.40
166 35.50
167 35.59
168 35.70
169 35.67
170 35.99
171 35.93
172 36.09
173 36.19
174 36.29
175 36.46
176 36.49
177 36.59
178 36.69
179 36.79
180 36.89
181 37.07
182 36.96
183 37.26
184 37.28
185 37.47
186 37.49
187 37.58
188 37.76
189 37.65
190 37.75
191 38.06
192 38.09
193 38.13
194 38.16
195 38.26
196 38.42
197 38.68
198 38.57
199 38.73
200 38.77
201 38.87
202 39.10
203 39.20
204 39.17
205 39.41
206 39.51
207 39.47
208 39.58
209 39.68
210 39.78
211 39.88
212 39.98
213 40.09
214 40.19
215 40.29
216 40.39
217 40.50
218 40.60
219 40.70
220 40.89
221 40.90
222 41.00
223 41.10
224 41.20
225 41.31
226 41.41
227 41.51
228 41.61
229 41.71
230 41.81
231 41.91
232 42.01
233 42.12
234 42.22
235 42.32
236 42.42
237 42.52
238 42.62
239 42.72
240 42.82
241 42.92
242 43.03
243 43.12
244 43.22
245 43.24
246 43.42
247 43.52
248 43.62
249 43.72
250 43.82
251 43.83
252 44.01
253 44.11
254 44.21
255 44.22
256 22.33
257 22.40
258 22.47
259 22.55
260 22.62
261 22.71
262 22.79
263 22.87
264 22.99
265 23.09
266 23.19
267 23.28
268 23.38
269 23.50
270 23.61
271 23.72
272 23.87
273 23.99
274 24.12
275 24.25
276 24.36
277 24.53
278 24.67
279 24.82
280 24.98
281 25.13
282 25.28
283 25.43
284 25.59
285 25.76
286 25.92
287 26.08
288 26.26
289 26.44
290 26.61
291 26.78
292 26.95
293 27.14
294 27.31
295 27.48
296 27.68
297 27.87
298 28.05
299 28.22
300 28.39
301 28.58
302 28.76
303 28.94
304 29.14
305 29.34
306 29.53
307 29.71
308 29.90
309 30.10
310 30.29
311 30.48
312 30.68
313 30.88
314 31.08
315 31.27
316 31.46
317 31.67
318 31.80
319 32.05
320 32.29
321 32.49
322 32.69
323 32.89
324 33.08
325 33.29
326 33.49
327 33.69
328 33.91
329 34.12
330 34.29
331 34.46
332 34.70
333 34.84
334 35.11
335 35.23
336 35.45
337 35.74
338 35.87
339 36.08
340 36.14
341 36.57
342 36.63
343 36.89
344 37.10
345 37.31
346 37.51
347 37.71
348 37.78
349 38.05
350 38.19
351 38.39
352 38.60
353 38.82
354 39.03
355 39.22
356 39.42
357 39.64
358 39.84
359 40.03
360 40.25
361 40.47
362 40.67
363 40.87
364 41.07
365 41.28
366 41.49
367 41.68
368 41.88
369 42.10
370 42.31
371 42.50
372 42.70
373 42.92
374 43.13
375 43.33
376 43.53
377 43.74
378 43.95
379 44.14
380 44.34
381 44.56
382 44.75
383 44.94
384 45.18
385 45.39
386 45.60
387 45.80
388 46.00
389 46.21
390 46.41
391 46.60
392 46.81
393 47.02
394 47.22
395 47.42
396 47.62
397 47.83
398 48.03
399 48.23
400 48.44
401 48.66
402 48.86
403 49.06
404 49.25
405 49.46
406 49.57
407 49.77
408 49.98
409 50.28
410 50.39
411 50.68
412 50.80
413 51.08
414 51.28
415 51.46
416 51.60
417 51.90
418 51.88
419 52.21
420 52.50
421 52.62
422 52.90
423 53.09
424 53.31
425 53.52
426 53.72
427 53.92
428 54.11
429 54.32
430 54.52
431 54.71
432 54.86
433 55.14
434 55.33
435 55.53
436 55.73
437 55.84
438 56.04
439 56.32
440 56.53
441 56.74
442 56.95
443 57.14
444 57.33
445 57.54
446 57.74
447 57.93
448 58.15
449 58.36
450 58.70
451 58.77
452 59.09
453 59.17
454 59.37
455 59.57
456 59.78
457 60.00
458 60.20
459 60.39
460 60.59
461 60.81
462 61.00
463 61.19
464 61.42
465 61.63
466 61.84
467 62.16
468 62.23
469 62.44
470 62.64
471 62.84
472 63.05
473 63.26
474 63.47
475 63.66
476 63.86
477 64.07
478 64.27
479 64.38
480 64.59
481 64.89
482 65.10
483 65.29
484 65.49
485 65.61
486 65.81
487 66.00
488 66.22
489 66.45
490 66.64
491 66.84
492 67.04
493 67.25
494 67.46
495 67.59
496 67.88
497 68.08
498 68.36
499 68.47
500 68.67
501 68.88
502 68.96
503 69.28
504 69.49
505 69.70
506 69.99
507 70.10
508 70.23
509 70.44
510 70.57
511 70.78
512 22.11
513 22.17
514 22.22
515 22.27
516 22.33
517 22.40
518 22.46
519 22.53
520 22.60
521 22.67
522 22.73
523 22.81
524 22.87
525 22.94
526 23.01
527 23.08
528 23.17
529 23.25
530 23.33
531 23.41
532 23.49
533 23.58
534 23.66
535 23.73
536 23.83
537 23.92
538 24.01
539 24.10
540 24.19
541 24.28
542 24.37
543 24.46
544 24.58
545 24.69
546 24.78
547 24.89
548 24.99
549 25.10
550 25.20
551 25.30
552 25.42
553 25.53
554 25.63
555 25.73
556 25.84
557 25.96
558 26.06
559 26.16
560 26.28
561 26.40
562 26.51
563 26.61
564 26.72
565 26.83
566 26.94
567 27.05
568 27.17
569 27.28
570 27.40
571 27.51
572 27.63
573 27.75
574 27.87
575 27.98
576 28.12
577 28.25
578 28.36
579 28.48
580 28.59
581 28.72
582 28.83
583 28.95
584 29.09
585 29.21
586 29.34
587 29.46
588 29.58
589 29.71
590 29.83
591 29.94
592 30.08
593 30.21
594 30.33
595 30.46
596 30.58
597 30.71
598 30.83
599 30.95
600 31.09
601 31.22
602 31.34
603 31.46
604 31.59
605 31.72
606 31.84
607 31.96
608 32.07
609 32.23
610 32.36
611 32.41
612 32.61
613 32.74
614 32.87
615 33.00
616 33.08
617 33.28
618 33.32
619 33.53
620 33.65
621 33.71
622 33.91
623 34.04
624 34.17
625 34.31
626 34.44
627 34.57
628 34.69
629 34.82
630 34.95
631 35.00
632 35.21
633 35.35
634 35.40
635 35.39
636 35.73
637 35.87
638 36.00
639 36.04
640 36.28
641 36.42
642 36.55
643 36.60
644 36.81
645 36.95
646 37.00
647 37.21
648 37.35
649 37.49
650 37.62
651 37.75
652 37.88
653 37.93
654 38.06
655 38.19
656 38.33
657 38.56
658 38.61
659 38.73
660 38.86
661 39.08
662 39.00
663 39.26
664 39.39
665 39.40
666 39.67
667 39.66
668 39.92
669 40.03
670 40.06
671 40.19
672 40.47
673 40.48
674 40.61
675 40.96
676 40.88
677 41.02
678 41.15
679 41.27
680 41.44
681 41.56
682 41.69
683 41.82
684 41.95
685 42.09
686 42.35
687 42.35
688 42.49
689 42.69
690 42.76
691 42.89
692 43.02
693 43.16
694 43.29
695 43.42
696 43.56
697 43.70
698 43.84
699 43.97
700 44.10
701 44.24
702 44.37
703 44.50
704 44.65
705 44.79
706 44.92
707 45.04
708 45.17
709 45.31
710 45.44
711 45.57
712 45.72
713 45.85
714 45.91
715 46.12
716 46.25
717 46.39
718 46.52
719 46.65
720 46.80
721 46.93
722 47.07
723 47.20
724 47.33
725 47.47
726 47.61
727 47.65
728 47.87
729 48.02
730 48.06
731 48.28
732 48.33
733 48.54
734 48.60
735 48.73
736 48.88
737 49.00
738 49.14
739 49.26
740 49.39
741 49.62
742 49.66
743 49.79
744 49.94
745 50.16
746 50.21
747 50.43
748 50.55
749 50.60
750 50.80
751 50.87
752 51.00
753 51.15
754 51.29
755 51.50
756 51.55
757 51.70
758 51.82
759 51.89
760 51.96
761 52.23
762 52.45
763 52.50
764 52.62
765 52.63
766 52.77
767 52.95
768 24.08
769 24.23
770 24.37
771 24.52
772 24.69
773 24.87
774 25.06
775 25.26
776 25.51
777 25.76
778 25.99
779 26.20
780 26.40
781 26.70
782 27.04
783 27.33
784 27.66
785 27.91
786 28.30
787 28.62
788 28.94
789 29.25
790 29.57
791 29.99
792 30.36
793 30.68
794 31.11
795 31.42
796 31.87
797 32.19
798 32.58
799 32.95
800 33.44
801 33.86
802 34.19
803 34.45
804 34.85
805 35.42
806 35.69
807 36.09
808 36.53
809 36.96
810 37.50
811 37.77
812 38.17
813 38.74
814 39.01
815 39.42
816 39.97
817 40.28
818 40.71
819 41.12
820 41.53
821 41.97
822 42.39
823 42.93
824 43.37
825 43.68
826 44.11
827 44.52
828 44.92
829 45.37
830 45.79
831 46.20
832 46.81
833 47.14
834 47.57
835 47.99
836 48.40
837 48.98
838 49.28
839 49.68
840 50.14
841 50.59
842 51.02
843 51.35
844 51.86
845 52.30
846 52.64
847 53.14
848 53.50
849 53.95
850 54.39
851 54.80
852 55.30
853 55.67
854 56.17
855 56.58
856 57.02
857 57.38
858 57.81
859 58.22
860 58.51
861 59.08
862 59.38
863 59.91
864 60.22
865 60.80
866 61.30
867 61.52
868 61.93
869 62.50
870 62.93
871 63.21
872 63.79
873 64.11
874 64.60
875 64.95
876 65.42
877 65.80
878 66.34
879 66.62
880 67.04
881 67.49
882 67.92
883 68.33
884 68.75
885 69.19
886 69.74
887 70.15
888 70.46
889 70.90
890 71.32
891 71.73
892 72.13
893 72.58
894 73.00
895 73.31
896 73.88
897 74.38
898 74.74
899 75.14
900 75.46
901 75.97
902 76.38
903 76.77
904 77.20
905 77.54
906 77.94
907 78.32
908 78.77
909 79.21
910 79.60
911 79.90
912 80.40
913 80.73
914 81.21
915 81.57
916 81.98
917 82.44
918 82.76
919 83.13
920 83.64
921 83.83
922 84.30
923 84.64
924 85.03
925 85.43
926 85.80
927 86.17
928 86.56
929 86.95
930 87.31
931 87.59
932 87.95
933 88.42
934 88.90
935 89.10
936 89.42
937 89.84
938 90.17
939 90.60
940 90.95
941 91.24
942 91.67
943 92.09
944 92.30
945 92.75
946 93.11
947 93.45
948 93.71
949 94.07
950 94.41
951 94.75
952 95.10
953 95.47
954 95.81
955 96.14
956 96.47
957 96.70
958 97.16
959 97.48
960 97.84
961 98.20
962 98.54
963 98.66
964 99.18
965 99.54
966 99.86
967 100.18
968 100.53
969 100.76
970 101.20
971 101.46
972 101.82
973 102.04
974 102.35
975 102.66
976 102.99
977 103.31
978 103.57
979 103.88
980 104.26
981 104.59
982 104.87
983 105.25
984 105.48
985 105.76
986 106.12
987 106.34
988 106.65
989 107.03
990 107.31
991 107.59
992 107.84
993 108.15
994 108.44
995 108.73
996 109.02
997 109.33
998 109.62
999 109.89
1000 110.19
1001 110.49
1002 110.77
1003 111.05
1004 111.32
1005 111.61
1006 111.88
1007 111.95
1008 112.42
1009 112.73
1010 112.99
1011 113.25
1012 113.52
1013 113.79
1014 114.07
1015 114.31
1016 114.58
1017 114.86
1018 115.11
1019 115.37
1020 115.55
1021 115.77
1022 116.14
1023 116.38
1024 29.68
1025 29.90
1026 29.92
1027 29.94
1028 30.03
1029 30.34
1030 30.21
1031 30.30
1032 30.55
1033 30.59
1034 30.70
1035 30.74
1036 30.85
1037 30.97
1038 31.09
1039 31.20
1040 31.18
1041 31.12
1042 31.09
1043 30.79
1044 30.30
1045 29.58
1046 28.91
1047 28.09
1048 27.34
1049 26.65
1050 26.36
1051 26.28
1052 26.42
1053 26.57
1054 26.71
1055 26.85
1056 27.03
1057 27.18
1058 27.33
1059 27.40
1060 27.62
1061 27.78
1062 27.92
1063 28.07
1064 28.24
1065 28.40
1066 28.55
1067 28.69
1068 28.85
1069 28.94
1070 29.09
1071 29.33
1072 29.50
1073 29.68
1074 29.85
1075 30.02
1076 30.15
1077 30.33
1078 30.52
1079 30.68
1080 30.86
1081 31.04
1082 31.22
1083 31.39
1084 31.56
1085 31.67
1086 31.92
1087 32.09
1088 32.30
1089 32.49
1090 32.67
1091 32.84
1092 33.02
1093 33.21
1094 33.39
1095 33.49
1096 33.76
1097 33.75
1098 34.14
1099 34.32
1100 34.47
1101 34.69
1102 34.86
1103 34.89
1104 35.17
1105 35.45
1106 35.63
1107 35.81
1108 35.97
1109 36.20
1110 36.38
1111 36.56
1112 36.76
1113 36.88
1114 37.06
1115 37.33
1116 37.31
1117 37.63
1118 37.81
1119 37.87
1120 38.20
1121 38.40
1122 38.46
1123 38.77
1124 39.04
1125 39.16
1126 39.34
1127 39.39
1128 39.73
1129 39.80
1130 40.20
1131 40.31
1132 40.50
1133 40.62
1134 40.88
1135 40.94
1136 41.14
1137 41.34
1138 41.54
1139 41.73
1140 41.92
1141 42.12
1142 42.31
1143 42.50
1144 42.83
1145 42.90
1146 43.23
1147 43.28
1148 43.54
1149 43.67
1150 44.00
1151 44.05
1152 44.40
1153 44.48
1154 44.67
1155 44.81
1156 45.05
1157 45.26
1158 45.45
1159 45.63
1160 45.84
1161 46.04
1162 46.23
1163 46.43
1164 46.62
1165 46.82
1166 46.93
1167 47.20
1168 47.40
1169 47.53
1170 47.81
1171 48.00
1172 48.19
1173 48.31
1174 48.58
1175 48.77
1176 48.95
1177 49.17
1178 49.37
1179 49.47
1180 49.75
1181 49.86
1182 50.13
1183 50.24
1184 50.45
1185 50.75
1186 50.86
1187 51.05
1188 51.33
1189 51.45
1190 51.65
1191 51.92
1192 52.05
1193 52.13
1194 52.45
1195 52.64
1196 52.70
1197 53.04
1198 53.22
1199 53.41
1200 53.62
1201 53.70
1202 54.02
1203 54.21
1204 54.40
1205 54.49
1206 54.68
1207 54.99
1208 55.20
1209 55.40
1210 55.60
1211 55.66
1212 55.98
1213 56.05
1214 56.25
1215 56.58
1216 56.66
1217 56.87
1218 57.06
1219 57.26
1220 57.57
1221 57.65
1222 57.85
1223 58.04
1224 58.31
1225 58.45
1226 58.65
1227 58.97
1228 59.03
1229 59.24
1230 59.62
1231 59.61
1232 59.82
1233 60.04
1234 60.23
1235 60.33
1236 60.53
1237 60.95
1238 61.01
1239 61.21
1240 61.47
1241 61.61
1242 61.81
1243 62.13
1244 62.18
1245 62.40
1246 62.57
1247 62.77
1248 62.89
1249 63.19
1250 63.29
1251 63.57
1252 63.76
1253 63.97
1254 64.13
1255 64.26
1256 64.55
1257 64.76
1258 64.88
1259 65.15
1260 65.34
1261 65.55
1262 65.74
1263 65.92
1264 66.13
1265 66.24
1266 66.44
1267 66.64
1268 66.82
1269 67.02
1270 67.21
1271 67.50
1272 67.61
1273 67.81
1274 68.01
1275 68.20
1276 68.38
1277 68.58
1278 68.77
1279 68.97
1280 25.64
1281 26.00
1282 26.08
1283 26.40
1284 26.37
1285 26.58
1286 26.98
1287 27.17
1288 27.30
1289 27.53
1290 27.72
1291 28.10
1292 28.33
1293 28.53
1294 28.62
1295 28.87
1296 29.18
1297 29.26
1298 29.52
1299 29.31
1300 29.45
1301 29.69
1302 29.97
1303 30.26
1304 30.52
1305 30.93
1306 31.21
1307 31.54
1308 31.86
1309 32.20
1310 32.51
1311 32.84
1312 33.01
1313 33.59
1314 33.86
1315 34.20
1316 34.41
1317 35.01
1318 35.27
1319 35.70
1320 36.10
1321 36.40
1322 36.84
1323 36.98
1324 37.34
1325 37.86
1326 38.30
1327 38.59
1328 38.98
1329 39.39
1330 39.77
1331 40.07
1332 40.52
1333 40.79
1334 41.17
1335 41.67
1336 41.93
1337 42.48
1338 42.93
1339 43.11
1340 43.49
1341 44.03
1342 44.34
1343 44.66
1344 45.24
1345 45.53
1346 45.93
1347 46.30
1348 46.82
1349 47.11
1350 47.49
1351 47.87
1352 48.30
1353 48.71
1354 49.11
1355 49.50
1356 49.88
1357 50.31
1358 50.61
1359 51.08
1360 51.43
1361 51.84
1362 52.34
1363 52.64
1364 53.06
1365 53.46
1366 53.85
1367 54.25
1368 54.71
1369 55.16
1370 55.36
1371 55.74
1372 56.13
1373 56.69
1374 56.95
1375 57.46
1376 57.89
1377 58.18
1378 58.59
1379 58.97
1380 59.37
1381 59.92
1382 60.18
1383 60.57
1384 61.01
1385 61.42
1386 61.96
1387 62.23
1388 62.61
1389 62.95
1390 63.43
1391 63.72
1392 64.20
1393 64.66
1394 64.96
1395 65.35
1396 65.84
1397 66.25
1398 66.64
1399 67.04
1400 67.41
1401 67.77
1402 68.18
1403 68.56
1404 68.95
1405 69.38
1406 69.77
1407 70.24
1408 70.62
1409 71.02
1410 71.45
1411 71.83
1412 72.20
1413 72.71
1414 73.09
1415 73.40
1416 73.82
1417 74.12
1418 74.63
1419 75.01
1420 75.39
1421 75.80
1422 76.18
1423 76.54
1424 76.95
1425 77.36
1426 77.80
1427 78.11
1428 78.48
1429 78.81
1430 79.24
1431 79.61
1432 79.99
1433 80.38
1434 80.63
1435 81.20
1436 81.46
1437 81.86
1438 82.14
1439 82.55
1440 82.95
1441 83.32
1442 83.69
1443 84.04
1444 84.27
1445 84.64
1446 85.11
1447 85.34
1448 85.71
1449 86.21
1450 86.56
1451 86.89
1452 87.23
1453 87.48
1454 87.72
1455 88.27
1456 88.49
1457 88.98
1458 89.33
1459 89.53
1460 89.92
1461 90.22
1462 90.67
1463 90.94
1464 91.23
1465 91.57
1466 91.96
1467 92.34
1468 92.66
1469 93.00
1470 93.32
1471 93.43
1472 93.99
1473 94.34
1474 94.46
1475 94.78
1476 95.17
1477 95.59
1478 95.94
1479 96.05
1480 96.47
1481 96.80
1482 97.04
1483 97.35
1484 97.85
1485 98.16
1486 98.48
1487 98.67
1488 98.98
1489 99.37
1490 99.65
1491 100.06
1492 100.15
1493 100.57
1494 100.98
1495 101.07
1496 101.53
1497 101.87
1498 102.00
1499 102.41
1500 102.58
1501 103.09
1502 103.24
1503 103.47
1504 103.90
1505 104.24
1506 104.51
1507 104.67
1508 105.07
1509 105.45
1510 105.68
1511 105.88
1512 106.12
1513 106.42
1514 106.72
1515 107.05
1516 107.34
1517 107.66
1518 107.82
1519 108.29
1520 108.55
1521 108.74
1522 109.05
1523 109.27
1524 109.47
1525 109.80
1526 110.02
1527 110.35
1528 110.55
1529 110.91
1530 111.09
1531 111.37
1532 111.61
1533 111.88
1534 112.14
1535 112.46
1536 29.40
1537 29.60
1538 29.56
1539 29.74
1540 29.82
1541 30.05
1542 30.11
1543 30.34
1544 30.41
1545 30.46
1546 30.79
1547 30.82
1548 30.90
1549 31.19
1550 31.21
1551 31.38
1552 31.59
1553 31.58
1554 31.55
1555 31.16
1556 30.64
1557 29.83
1558 28.96
1559 28.17
1560 27.57
1561 27.71
1562 27.89
1563 28.08
1564 28.27
1565 28.48
1566 28.68
1567 28.86
1568 29.10
1569 29.31
1570 29.52
1571 29.73
1572 29.94
1573 30.17
1574 30.38
1575 30.59
1576 30.83
1577 31.06
1578 31.20
1579 31.42
1580 31.64
1581 31.96
1582 32.11
1583 32.40
1584 32.65
1585 32.90
1586 33.13
1587 33.36
1588 33.57
1589 33.85
1590 34.00
1591 34.29
1592 34.56
1593 34.74
1594 35.06
1595 35.30
1596 35.46
1597 35.80
1598 35.96
1599 36.27
1600 36.49
1601 36.83
1602 36.87
1603 37.24
1604 37.35
1605 37.61
1606 38.07
1607 38.23
1608 38.58
1609 38.81
1610 38.87
1611 39.33
1612 39.49
1613 39.77
1614 39.88
1615 40.26
1616 40.41
1617 40.75
1618 40.95
1619 41.20
1620 41.51
1621 41.72
1622 41.96
1623 42.35
1624 42.48
1625 42.75
1626 43.01
1627 43.26
1628 43.51
1629 43.95
1630 44.04
1631 44.29
1632 44.57
1633 44.84
1634 45.10
1635 45.36
1636 45.61
1637 45.88
1638 46.14
1639 46.39
1640 46.67
1641 46.94
1642 47.20
1643 47.45
1644 47.68
1645 47.98
1646 48.24
1647 48.49
1648 48.76
1649 49.04
1650 49.29
1651 49.46
1652 49.81
1653 49.99
1654 50.34
1655 50.60
1656 50.87
1657 51.14
1658 51.41
1659 51.58
1660 51.84
1661 52.05
1662 52.24
1663 52.62
1664 52.92
1665 53.20
1666 53.34
1667 53.73
1668 53.85
1669 54.26
1670 54.51
1671 54.64
1672 55.06
1673 55.33
1674 55.59
1675 55.86
1676 56.10
1677 56.25
1678 56.52
1679 56.77
1680 57.05
1681 57.34
1682 57.72
1683 57.98
1684 58.11
1685 58.52
1686 58.65
1687 59.03
1688 59.17
1689 59.45
1690 59.71
1691 59.97
1692 60.22
1693 60.51
1694 60.76
1695 61.02
1696 61.30
1697 61.58
1698 61.84
1699 62.10
1700 62.36
1701 62.55
1702 62.81
1703 63.06
1704 63.41
1705 63.71
1706 63.95
1707 64.14
1708 64.48
1709 64.76
1710 65.01
1711 65.27
1712 65.54
1713 65.73
1714 66.08
1715 66.31
1716 66.50
1717 66.78
1718 67.12
1719 67.37
1720 67.55
1721 67.83
1722 68.10
1723 68.35
1724 68.60
1725 68.88
1726 69.13
1727 69.39
1728 69.68
1729 70.04
1730 70.22
1731 70.48
1732 70.74
1733 71.01
1734 71.26
1735 71.52
1736 71.80
1737 72.07
1738 72.33
1739 72.59
1740 72.84
1741 72.99
1742 73.37
1743 73.62
1744 73.77
1745 74.05
1746 74.44
1747 74.68
1748 74.93
1749 75.07
1750 75.46
1751 75.63
1752 75.96
1753 76.02
1754 76.42
1755 76.73
1756 76.98
1757 77.23
1758 77.47
1759 77.60
1760 77.97
1761 78.11
1762 78.49
1763 78.72
1764 78.90
1765 79.24
1766 79.47
1767 79.70
1768 79.85
1769 80.23
1770 80.34
1771 80.65
1772 80.93
1773 81.06
1774 81.42
1775 81.65
1776 81.90
1777 82.15
1778 82.27
1779 82.62
1780 82.85
1781 82.98
1782 83.21
1783 83.51
1784 83.74
1785 83.99
1786 84.18
1787 84.39
1788 84.74
1789 85.00
1790 85.22
1791 85.32
1792 26.55
1793 26.82
1794 27.22
1795 27.51
1796 27.90
1797 28.20
1798 28.77
1799 29.22
1800 29.64
1801 30.20
1802 30.74
1803 31.43
1804 31.88
1805 32.65
1806 33.34
1807 33.89
1808 34.63
1809 35.43
1810 36.06
1811 36.63
1812 37.46
1813 38.23
1814 38.83
1815 39.69
1816 40.35
1817 41.15
1818 42.07
1819 42.71
1820 43.48
1821 44.31
1822 45.10
1823 46.00
1824 46.74
1825 47.61
1826 48.44
1827 49.24
1828 49.95
1829 50.91
1830 51.73
1831 52.46
1832 53.44
1833 54.32
1834 55.17
1835 55.98
1836 56.58
1837 57.58
1838 58.41
1839 59.23
1840 60.01
1841 60.96
1842 61.70
1843 62.51
1844 63.32
1845 64.22
1846 65.03
1847 65.85
1848 66.70
1849 67.59
1850 68.34
1851 69.16
1852 70.06
1853 70.94
1854 71.67
1855 72.57
1856 73.43
1857 74.40
1858 75.14
1859 75.93
1860 76.72
1861 77.57
1862 78.35
1863 79.00
1864 79.96
1865 80.78
1866 81.56
1867 82.31
1868 83.04
1869 83.83
1870 84.45
1871 85.30
1872 86.08
1873 86.73
1874 87.48
1875 88.30
1876 89.01
1877 89.64
1878 90.46
1879 91.14
1880 91.80
1881 92.59
1882 93.17
1883 93.87
1884 94.61
1885 95.33
1886 95.77
1887 96.62
1888 97.30
1889 98.01
1890 98.68
1891 99.25
1892 99.82
1893 100.51
1894 101.13
1895 101.73
1896 102.54
1897 103.15
1898 103.83
1899 104.30
1900 105.02
1901 105.65
1902 106.12
1903 106.63
1904 107.43
1905 108.04
1906 108.44
1907 109.00
1908 109.64
1909 110.30
1910 110.71
1911 111.25
1912 111.81
1913 112.39
1914 112.93
1915 113.46
1916 113.97
1917 114.52
1918 115.00
1919 115.52
1920 116.12
1921 116.65
1922 117.15
1923 117.63
1924 118.05
1925 118.63
1926 118.98
1927 119.50
1928 119.90
1929 120.51
1930 120.86
1931 121.42
1932 121.77
1933 122.33
1934 122.77
1935 123.09
1936 123.58
1937 124.03
1938 124.46
1939 124.89
1940 125.29
1941 125.71
1942 126.17
1943 126.54
1944 126.89
1945 127.41
1946 127.75
1947 128.01
1948 128.57
1949 128.93
1950 129.22
1951 129.69
1952 130.12
1953 130.45
1954 130.78
1955 131.11
1956 131.47
1957 131.86
1958 132.23
1959 132.58
1960 132.96
1961 133.34
1962 133.75
1963 134.05
1964 134.39
1965 134.87
1966 135.21
1967 135.31
1968 135.87
1969 136.15
1970 136.46
1971 136.79
1972 137.14
1973 137.47
1974 137.79
1975 138.12
1976 138.43
1977 138.77
1978 139.16
1979 139.34
1980 139.74
1981 140.04
1982 140.34
1983 140.71
1984 141.00
1985 141.30
1986 141.67
1987 141.93
1988 142.27
1989 142.47
1990 142.76
1991 143.06
1992 143.43
1993 143.61
1994 143.89
1995 144.20
1996 144.56
1997 144.78
1998 145.04
1999 145.25
2000 145.64
2001 145.93
2002 146.25
2003 146.41
2004 146.68
2005 146.96
2006 147.30
2007 147.46
2008 147.85
2009 148.09
2010 148.26
2011 148.51
2012 148.76
2013 149.06
2014 149.26
2015 149.54
2016 149.84
2017 150.10
2018 150.34
2019 150.58
2020 150.68
2021 151.07
2022 151.31
2023 151.47
2024 151.69
2025 151.89
2026 152.16
2027 152.34
2028 152.68
2029 152.81
2030 153.03
2031 153.26
2032 153.36
2033 153.72
2034 153.82
2035 154.14
2036 154.28
2037 154.52
2038 154.85
2039 154.88
2040 155.19

--=-=-=--
