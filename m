Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A7633FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiKVPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKVPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:05:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5140CD8;
        Tue, 22 Nov 2022 07:05:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so23971666lfi.7;
        Tue, 22 Nov 2022 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joRULvf1dWJkA5gWRTFhFCk8AeaMUxC+7TLKjnw2DLE=;
        b=ER2Fw8emECT/rQge+eiBNkkviWG3kjbWsZCbV4x/Kgaljhp2rzXGAQygNJar3+6u44
         QevH09MxTl6kJbQ0qPaESjwxa4GjqJr5YoXGhhnbrnofLSwud68+an31l+2EwkoR/nKs
         Jg/cq7+qg2c1ILnIHDzqchGtMVrSKVGnJqH2FWFWAtbSvYbvhMwEa8bHPst5szIVBUuz
         E85pH8kn9kRscODxb12XOnTFG+LM/br7nINFu+sS95yQ+OAwa+nmSbUSpQRV2lK1igRp
         pQYKCnvgr/K31pf+OvF/dh9Xe0hZmw9rDcyEPaxUi6by+xYUymVne6HaWNeGLjtJRNg8
         JEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=joRULvf1dWJkA5gWRTFhFCk8AeaMUxC+7TLKjnw2DLE=;
        b=UP1bQPiizPVTUBdOK/rc5VVxB5SaBYHppTcGii8JM1vSZP3bEorzwpojRmZquDI74J
         umTHlAsKQjV4OO6ToIWai6AH2I9K43teIImDJoU8cRw1iPlMWzE4TJ/9Ngp26paa7g1L
         M84p6+IWIZVG49md4XFQQ2gVUszQDq+oz0zmy1i27T3mUMS3dx+ovPDb3Wwtxd+19wCl
         ko9X1Fhpo4ncAUG8quGYbyCI/bnxTSAiRkEssJRnUsbQFRpJKKEx7Qc5dGImfZEp62kk
         pD5AXRzrIeBBW0AbOyipG7jIYdH3v3om0FESBo3Y7huR4JVEjBVYb+yzedAaxzy0QEF7
         laNg==
X-Gm-Message-State: ANoB5plbH5FD0Qwp1pgvwZEYLxzJQ6vv7V4JD79BbzmH4yz7fLSh43sw
        IJydtlyRyJ9uG7yHHrEgR1w=
X-Google-Smtp-Source: AA0mqf5OHYaGctuWCwcgr2ujiVoDrGqiB2RNftQYRObwVAsJZmt9XYndfhnGYv2vqwN8PdQGXddxvA==
X-Received: by 2002:ac2:4a6a:0:b0:4b1:753b:e66f with SMTP id q10-20020ac24a6a000000b004b1753be66fmr2180872lfp.276.1669129536433;
        Tue, 22 Nov 2022 07:05:36 -0800 (PST)
Received: from razdolb (95-31-185-17.broadband.corbina.ru. [95.31.185.17])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b0049478cc4eb9sm2499071lfo.230.2022.11.22.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:05:35 -0800 (PST)
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net> <YzNTB+RQK6yITi7/@Red>
 <YzNthZ0MtfwjIqdH@aurel32.net> <YzVNBcF7TCDldPwF@Red>
 <87y1sasrf2.fsf@gmail.com> <Y3zOn5IO1ziJXKUT@Red>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Date:   Tue, 22 Nov 2022 18:04:00 +0300
In-reply-to: <Y3zOn5IO1ziJXKUT@Red>
Message-ID: <877cznni69.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-11-22 at 14:29 +01, Corentin LABBE <clabbe@baylibre.com> wrote:

> Le Wed, Nov 16, 2022 at 09:04:07PM +0300, Mikhail Rudenko a =C3=A9crit :
>>
>> On 2022-09-29 at 09:45 +02, LABBE Corentin <clabbe@baylibre.com> wrote:
>> > Le Tue, Sep 27, 2022 at 11:39:17PM +0200, Aurelien Jarno a =C3=A9crit :
>> >> On 2022-09-27 21:46, LABBE Corentin wrote:
>> >> > Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a =C3=A9cr=
it :
>> >> > > On 2022-09-20 10:35, Robin Murphy wrote:
>> >> > > > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
>> >> > > > > The Rockchip driver has long existed out of tree, but not ups=
tream.
>> >> > > > > There is support for it upstream in u-boot, but not in Linux =
proper.
>> >> > > > > This commit imports the GPLv2 driver written by Lin Jinhan, t=
ogether
>> >> > > > > with the DTS and config blobs from Wevsty.
>> >> > > >
>> >> > > > Note that Corentin has a series enabling the full crypto driver=
 for
>> >> > > > RK3328 and RK3399[1], so it would seem more sensible to add TRN=
G support
>> >> > > > to that. Having confliciting compatibles for the same hardware =
that
>> >> > > > force the user to change their DT to choose one functionality o=
r the
>> >> > > > other isn't good (plus there's also no binding for this one).
>> >> > >
>> >> > > It might make sense for the cryptov1-rng driver (I haven't checke=
d). For
>> >> > > the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find=
 the
>> >> > > RK3588 one), and from what I understand crypto and TRNG are two
>> >> > > different devices, using different address spaces, clock, reset a=
nd
>> >> > > interrupts. The vendor kernel uses two different drivers.
>> >> > >
>> >> >
>> >> > I confirm that TRNG is not on the same IP on rk3568, something I di=
dnt remark when doing my V2 driver. (I need to remove rng clock from rk3568=
 dt).
>> >> > But the rk3588 crypto IP and the TRNG are in the same device.
>> >>
>> >> Ok, thanks for confirming about the rk3568. It seems the only one in =
the
>> >> family with separate devices for TRNG and crypto. Does it means we ne=
ed
>> >> a separate TRNG driver only for it? Or could we handle it the same way
>> >> than for instance rk3588 anyway?
>> >
>> > I just got now the part 1 of rk3588 TRM which I has missing and it sho=
w some conflicting information.
>> > rk3588 seems to have both a dedicated TRNG (TRNG_NS/TRNG_S) with dedic=
ated address space and a TRNG inside the crypto IP.
>> > But for the moment, the TRNG inside crypto IP seems defective.
>>
>> So what's the ultimate decision? Does anyone work on merging this into
>> the existing crypto driver? I have a use case with an rk3399-based board,
>> where having hardware rng enhances boot times dramatically (at least for
>> some userspaces; see also [1]).
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216502
>>
>
> Hello
>
> I started to work on adding RNG to rk3288_crypto.
> I need to publish the work on my github and take time to send it for revi=
ew.

Glad to hear you are working on this. Please cc me when posting patches :)

>
> Regards

--
Best regards,
Mikhail Rudenko
