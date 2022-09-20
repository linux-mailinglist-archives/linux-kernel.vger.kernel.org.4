Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43B5BEEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiITUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiITUmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:42:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0BE76952;
        Tue, 20 Sep 2022 13:42:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so5829127lfo.8;
        Tue, 20 Sep 2022 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=jdNliw/euHOl0baaiAZe1hfvOGYdGmy+JAmkgX5+N9w=;
        b=hHhgq0hDYW6wuWZu8I2Bzym9SNelKLrUebmiUkCQfyGbm5dzfvAhC8bDSP0DhuVDst
         K91vM/NpPUEemiqg2+DVnZrELnCkfnZrQhwn6tixdir891VX2z1ta/W/VK1++hkT3E5P
         2b/u98ceKrx3WN2jn5O3XweOaLsdHHeK/modaZeCSRJeDy5NYb75p54aGeJQ+3NWwL0v
         UkOycXRDI6+hUbbQ0tO10fI6CTN8VdCu9ydVE9ZBa7tVdMF7wDXwyq1cC6ACVOjWjx+r
         bhYi0dd/gznh6+z7uAYuZnspoXdhEcP0xKkYeKzaIHO/XlcVKkkBQa1Lf4R6BG1xfmaK
         BrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=jdNliw/euHOl0baaiAZe1hfvOGYdGmy+JAmkgX5+N9w=;
        b=eFqUA3T3uY47J5S63z0DaCe1x2NfUtRIKm4WejeLdRILJBpU6dOwF9PllRbhIH60rq
         4vbOtOZeE6qDie4cX+860nYRaUQh60k7sFfsK4kulXX7g4RClAoMKJanSWlmFT735fDE
         LecDwhtc6jtTT+57WH/sYC7LoNoPpdWFKOKIB50tl4hLiUve+ZPoaiHJ/txR+6329Igx
         UIcB1UuZyQpqu2Xs1nQTFi2YIidzFE6gvgdmQMQC/sPZIcVLQuiGY/bQE6rSL4N2rumo
         yF09fyOaJbDYXLkjX/CQTr2u0/UvUgkSawLYefnCh4pEtOb4XloIiTDFh9/N1I3zs8co
         SoMQ==
X-Gm-Message-State: ACrzQf3zlVm++JX5vDXk0U9dEzbSeplha9S4oWP3k+2EZeSxR4kt4cRO
        XK2M2qFEOoq3Kg+/THiUMaGMZV7cLr52jw==
X-Google-Smtp-Source: AMsMyM7+o2VIN91LGTfhkwDzVdSsyhx97GIsPr0UXf/iFgCezWrtOeyhm07v7i24/VaXKGK2/OuqRQ==
X-Received: by 2002:a05:6512:409:b0:49a:e44a:c6b1 with SMTP id u9-20020a056512040900b0049ae44ac6b1mr8730712lfk.222.1663706528322;
        Tue, 20 Sep 2022 13:42:08 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b00494791fbd80sm108415lfs.307.2022.09.20.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:42:06 -0700 (PDT)
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
Date:   Tue, 20 Sep 2022 23:31:01 +0300
In-reply-to: <YyhzUvu0Ky8+VohC@pendragon.ideasonboard.com>
Message-ID: <87leqdkcbm.fsf@gmail.com>
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


Hi Laurent, Sakari,

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
>> > > Based on that it looks like their medication may have been a little too
>> > > strong.
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
>
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

I got some fresh data regarding gain setting, with gain register value
ranging from 0 to 4096, please check the attached plot. What is the best
way to expose this to userspace in your opinion?

--
Best regards,
Mikhail Rudenko

--=-=-=
Content-Type: application/pdf
Content-Disposition: attachment; filename=gain_2.pdf
Content-Transfer-Encoding: base64

JVBERi0xLjQKJcOiw6MKMSAwIG9iago8PAovVGl0bGUgKCkKL0NyZWF0b3IgKCkKL1Byb2R1Y2Vy
ICj+/wBRAHQAIAA1AC4AMQA1AC4ANikKL0NyZWF0aW9uRGF0ZSAoRDoyMDIyMDkyMDIzMzA0Misw
MycwMCcpCj4+CmVuZG9iagoyIDAgb2JqCjw8Ci9UeXBlIC9DYXRhbG9nCi9QYWdlcyAzIDAgUgo+
PgplbmRvYmoKNCAwIG9iago8PAovVHlwZSAvRXh0R1N0YXRlCi9TQSB0cnVlCi9TTSAwLjAyCi9j
YSAxLjAKL0NBIDEuMAovQUlTIGZhbHNlCi9TTWFzayAvTm9uZT4+CmVuZG9iago1IDAgb2JqClsv
UGF0dGVybiAvRGV2aWNlUkdCXQplbmRvYmoKNiAwIG9iago8PAovVHlwZSAvUGFnZQovUGFyZW50
IDMgMCBSCi9Db250ZW50cyA4IDAgUgovUmVzb3VyY2VzIDEwIDAgUgovQW5ub3RzIDExIDAgUgov
TWVkaWFCb3ggWzAgMCA5MTAuMDAwMDAwIDczNy4wMDAwMDBdCj4+CmVuZG9iagoxMCAwIG9iago8
PAovQ29sb3JTcGFjZSA8PAovUENTcCA1IDAgUgovQ1NwIC9EZXZpY2VSR0IKL0NTcGcgL0Rldmlj
ZUdyYXkKPj4KL0V4dEdTdGF0ZSA8PAovR1NhIDQgMCBSCj4+Ci9QYXR0ZXJuIDw8Cj4+Ci9Gb250
IDw8Ci9GNyA3IDAgUgo+PgovWE9iamVjdCA8PAo+Pgo+PgplbmRvYmoKMTEgMCBvYmoKWyBdCmVu
ZG9iago4IDAgb2JqCjw8Ci9MZW5ndGggOSAwIFIKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3Ry
ZWFtCnic5L3LruDIlZ09z6c4YwNOMe4RgGHALXcb8MBAQwV4YHhgqGEbjVbDggZ+ffO617eDZFVl
VdafKf0tqHXOl/vsxUvEYjC4Gfzdf/rD//j4X3/5+N3v//B/Pv54/u/v//Bp+VyX8/8+tv/8Ww9a
ah9//NOnP3/8+dM/fvrH9f9f/7v9458+hRLa+sO/HD+EGPv686Iftn/635/+67/5+Nf9D4//hs+1
1hhy6rvi9Ouqtm5CbLkso6/A/5xTSC2W/PGH3/+XNa7Ypv7fj/Dxn9f//vPHfyMOH/99+fj4p08l
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
b2JqCjEyIDAgb2JqCjw8IC9UeXBlIC9Gb250RGVzY3JpcHRvcgovRm9udE5hbWUgL1FNQUFBQStO
b3RvU2Fucy1SZWd1bGFyCi9GbGFncyA0IAovRm9udEJCb3ggWy02MjEgLTM4OSAyODAwIDEwNjcg
XQovSXRhbGljQW5nbGUgMCAKL0FzY2VudCAxMDY5IAovRGVzY2VudCAtMjkzIAovQ2FwSGVpZ2h0
IDEwNjkgCi9TdGVtViA1MCAKL0ZvbnRGaWxlMiAxMyAwIFIKL0NJRFNldCAxNiAwIFIKPj4KZW5k
b2JqCjEzIDAgb2JqCjw8Ci9MZW5ndGgxIDU2NTIgCi9MZW5ndGggMTcgMCBSCi9GaWx0ZXIgL0Zs
YXRlRGVjb2RlCj4+CnN0cmVhbQp4nJU3a3BT15nnu7qS/OBh+Y0NsSSDZRuEsYQkPwG/JFmWLWwL
2zjGWJbkp16WZMAhjuMQNhTC08YzZAnLNOzGYTshzRA6bWla2jRJQyjTJkxmt+1Od7p0dxaS7GSm
nQngy37n6MrEkB+trs+933fu936dawKEkATyPJEQ4mgv0R29dHAH7ryMq2/QNzHw/TPpiQjfJSTx
P4a8Lo+npfE6IUkf455xCDf4SMrnhCTziK8d8kf3DSiTjIgXUn5f0O1SNT91H/FDiOv8rn0hspo0
I34VcWXA5fd6zqluIv57lGkkPGeGE0RKCHeY60KKptgTeokOanE3WcrxUp7j+D8S7uE2osxLIKSI
pBBicTgsZBshDxd4rfA7QngtrEO+f0IZhMvmPqLaCE84cg3fJUmvoLdyQvQKlWKdSqG6JmlcyOMm
Fl6SXrlnG+L/jHSeh3f4EukNkkbyUU66XCaX5cs0BYrNJiNeuqxM4LIy9TqTMY3TFGjwLV9SqhsZ
vfT1+J5Nm0ZHLv1138SD/4WG+tdfs5gBzJbXXq9v4P5wd/7izm748ANwfzH/encXvP++cFb47ezc
6VkogfVzswCzc6iO9KOVRdKPiJoQlcoAVKXRUICK1GiIBhFlVmYWM0oOGSq+6EE5TAWamzQaMFsj
o9tbnX07QkHYuXcPbCpxOkPCTe5Pc3DA39nR3uae2FoN69bWTlj0pYND70TdXld/QPgkAX1ej1pH
pO+SJJKJRuQr8hWoW6/QA3U6nylT8SOfXlqo59768afCpFQiSUzJzskUbNwysAuXwX5G8m8PNsHH
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
0Xtap3sYb2CxwyZYZYdZjcRsinVs9G/I6uP9EEGLaWZDbPJuZLb58El9HMT3NPJ2lOBjO8MsNhG0
wI+1EMRdJ7PZt2gbnedR0V4XgyKsLh55alsSw6XccRqXeCq4EQoxjV5mdYwuglrcYk7i1Whh3nnZ
/GrHKhpm3elisjxLvFw6EztZBcVOHqc4wRuwimJz0b747hG0lL+Z6R9G3M+qiuawlkXGs/h8JO/R
m9iMGkX9w4jTzNWxnHm+MQOe3IlrePJNC4uon0WuTsw+1RgRzyMan6CYjzG01osnk5P1SxQ7aZhV
MbVpgpD/B+JFnBYKZW5kc3RyZWFtCmVuZG9iagoxNyAwIG9iagozNTgyCmVuZG9iagoxNCAwIG9i
ago8PCAvVHlwZSAvRm9udAovU3VidHlwZSAvQ0lERm9udFR5cGUyCi9CYXNlRm9udCAvTm90b1Nh
bnMtUmVndWxhcgovQ0lEU3lzdGVtSW5mbyA8PCAvUmVnaXN0cnkgKEFkb2JlKSAvT3JkZXJpbmcg
KElkZW50aXR5KSAvU3VwcGxlbWVudCAwID4+Ci9Gb250RGVzY3JpcHRvciAxMiAwIFIKL0NJRFRv
R0lETWFwIC9JZGVudGl0eQovVyBbMCBbNjAwIDI2MCBdCjIgMTEgNTcyIAoxMiBbNzI4IDU2MSAy
NTggNjE4IDQ4MCA2MDUgNjE1IDU2NCAzMjkgNTI5IDMyOSA1NzIgXQpdCj4+CmVuZG9iagoxNSAw
IG9iago8PCAvTGVuZ3RoIDUyNSA+PgpzdHJlYW0KL0NJREluaXQgL1Byb2NTZXQgZmluZHJlc291
cmNlIGJlZ2luCjEyIGRpY3QgYmVnaW4KYmVnaW5jbWFwCi9DSURTeXN0ZW1JbmZvIDw8IC9SZWdp
c3RyeSAoQWRvYmUpIC9PcmRlcmluZyAoVUNTKSAvU3VwcGxlbWVudCAwID4+IGRlZgovQ01hcE5h
bWUgL0Fkb2JlLUlkZW50aXR5LVVDUyBkZWYKL0NNYXBUeXBlIDIgZGVmCjEgYmVnaW5jb2Rlc3Bh
Y2VyYW5nZQo8MDAwMD4gPEZGRkY+CmVuZGNvZGVzcGFjZXJhbmdlCjIgYmVnaW5iZnJhbmdlCjww
MDAwPiA8MDAwMD4gPDAwMDA+CjwwMDAxPiA8MDAxNz4gWzwwMDA5PiA8MDAzMD4gPDAwMzI+IDww
MDM0PiA8MDAzNj4gPDAwMzg+IDwwMDMxPiA8MDAzNT4gPDAwMzc+IDwwMDMzPiA8MDAzOT4gPDAw
NDc+IDwwMDYxPiA8MDA2OT4gPDAwNkU+IDwwMDYzPiA8MDA2Rj4gPDAwNjQ+IDwwMDY1PiA8MDA1
Qj4gPDAwNzg+IDwwMDVEPiA8MDAzRD4gXQplbmRiZnJhbmdlCmVuZGNtYXAKQ01hcE5hbWUgY3Vy
cmVudGRpY3QgL0NNYXAgZGVmaW5lcmVzb3VyY2UgcG9wCmVuZAplbmQKCmVuZHN0cmVhbQplbmRv
YmoKNyAwIG9iago8PCAvVHlwZSAvRm9udAovU3VidHlwZSAvVHlwZTAKL0Jhc2VGb250IC9Ob3Rv
U2Fucy1SZWd1bGFyCi9FbmNvZGluZyAvSWRlbnRpdHktSAovRGVzY2VuZGFudEZvbnRzIFsxNCAw
IFJdCi9Ub1VuaWNvZGUgMTUgMCBSPj4KZW5kb2JqCjE2IDAgb2JqCjw8Ci9MZW5ndGggNAo+Pgpz
dHJlYW0K////AAplbmRzdHJlYW0KZW5kb2JqCjMgMCBvYmoKPDwKL1R5cGUgL1BhZ2VzCi9LaWRz
IApbCjYgMCBSCl0KL0NvdW50IDEKL1Byb2NTZXQgWy9QREYgL1RleHQgL0ltYWdlQiAvSW1hZ2VD
XQo+PgplbmRvYmoKeHJlZgowIDE4CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxNSAwMDAw
MCBuIAowMDAwMDAwMTMxIDAwMDAwIG4gCjAwMDAwNDQyMDMgMDAwMDAgbiAKMDAwMDAwMDE4MCAw
MDAwMCBuIAowMDAwMDAwMjc1IDAwMDAwIG4gCjAwMDAwMDAzMTIgMDAwMDAgbiAKMDAwMDA0NDAw
NyAwMDAwMCBuIAowMDAwMDAwNjMyIDAwMDAwIG4gCjAwMDAwMzkxOTkgMDAwMDAgbiAKMDAwMDAw
MDQ0NiAwMDAwMCBuIAowMDAwMDAwNjEyIDAwMDAwIG4gCjAwMDAwMzkyMjAgMDAwMDAgbiAKMDAw
MDAzOTQ0OCAwMDAwMCBuIAowMDAwMDQzMTQyIDAwMDAwIG4gCjAwMDAwNDM0MzAgMDAwMDAgbiAK
MDAwMDA0NDE0OSAwMDAwMCBuIAowMDAwMDQzMTIxIDAwMDAwIG4gCnRyYWlsZXIKPDwKL1NpemUg
MTggCi9JbmZvIDEgMCBSCi9Sb290IDIgMCBSCj4+CnN0YXJ0eHJlZgo0NDMwMSAKJSVFT0YK
--=-=-=--
