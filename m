Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2CF65AA57
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAAPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:34:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEE2DD3;
        Sun,  1 Jan 2023 07:34:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bn26so4723760wrb.0;
        Sun, 01 Jan 2023 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyql/ql31MrMiVenPPWixFjfQxaA/GXi4qA/mUssQCA=;
        b=XcldlBRq3hlCFz/bA8Cb3n/IBBocsWlT2pw9cwt90DMWSevCytY89OB1njE7BhCd/u
         neyFbo+dsh+O7c4KKZ9KjnIzfRkRRohCYG6wceemsQ+05bHkgYLNDodMV6n1MjIbAbRz
         dIrI68nbIyzIPOgtKuQYH60wjgFG6aQraNegS1jUV969r3T96c/3extP0KavdX/59RIJ
         EPz39pTul1Ez9rZPJPuj8RvF/7tiuWZQrMHpCpxsSzuFdqRaNzB8YDBn2nI5M3pRM26/
         ZHjefVad6U+Mf8hx3GFK/XTwvnRlshXRZJeOWfN6GZTGIeAIQH4DuiT8O7R6sYGga0wC
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyql/ql31MrMiVenPPWixFjfQxaA/GXi4qA/mUssQCA=;
        b=elqI3kMlKacy5/4e7OFwG4PPIyV5LxvMHVPUf70jdP6OBJab4CK0ZpzzpWkuXlJ4C4
         ESgTwIlx7ji7HyS2GLZor6ZlHkXSyk2ca4LytXQto/BRhCmv02az7CFErPLzFPv1LcoV
         EmU9EY5r6I1ZN2H/sPX1oBdOpWshDFhIEIcUXoAXnDiODZ7MxCo6mf8ym3baeTQmzBF/
         n/ljcqLu9khhXLhAcMfWd+/EA2AYdIqwOJmmNBGJ8ET4ogzgBkWb+jmW0DZpWaKZnUu/
         c+Mlwd5Ke0ran1rEzW/GFhaZx198Y14zUv7eslsHxQMTSiGODu9hef8rYq2AH1zxkYtu
         prIQ==
X-Gm-Message-State: AFqh2koYeBSyciiIo2GWOJh6hHgcY+toZpKSsQ+pvtkqpDjzky/+V5NL
        DiCerV0cTlqi3oTOYj39Kgp+kJawkmo=
X-Google-Smtp-Source: AMrXdXsAXtxQE8ZyOQIH8VzJVjwWquAzVdFkoCkC9qLipG7q5SHwLFgIXbJRnPHQnkmXTqQVau8xSw==
X-Received: by 2002:a5d:5b1a:0:b0:249:3f48:6040 with SMTP id bx26-20020a5d5b1a000000b002493f486040mr28656083wrb.21.1672587240658;
        Sun, 01 Jan 2023 07:34:00 -0800 (PST)
Received: from fedora ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b00273cd321a1bsm24886126wro.107.2023.01.01.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 07:34:00 -0800 (PST)
Date:   Sun, 1 Jan 2023 16:33:55 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     redstrate <josh@redstrate.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        kurikaesu@users.noreply.github.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Message-ID: <Y7Gn4wVx3CgGYSeA@fedora>
References: <2068502.VLH7GnMWUR@adrastea>
 <20221229190648.69040-1-jose.exposito89@gmail.com>
 <3448509.5fSG56mABF@adrastea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3448509.5fSG56mABF@adrastea>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Dec 30, 2022 at 03:02:41PM -0500, redstrate wrote:
> > Hi Joshua,
> > 
> > Thanks a lot for your patch!
> > 
> > It might cause conflicts with [1] and [2], so we'll need to rebase on
> > top of each other work at some point.
> > 
> > [1]
> > https://lore.kernel.org/linux-input/20221226123456.14822-1-jose.exposito89@
> > gmail.com/T/ [2]
> > https://lore.kernel.org/linux-input/20221226125454.16106-1-jose.exposito89@
> > gmail.com/T/
> 
> I've seen those patches in the mailing list (and I thought they already got 
> merged heh) so I'll keep a close eye and rebase as needed.
> 
> > 
> > Sparse nitpick: "uclogic_extra_input_mapping" can be made static.
> > 
> 
> I somehow missed that, will change.
> 
> > 
> > Is it possible to receive a report with information from both dials at
> > the same time?
> > 
> > I'm asking because I'm trying to understand what is the meaning of the
> > 0x10 and 0x20 values and I wonder if they are generated when both dials
> > are used at the same time.
> > 
> 
> According to Aren's reference sheet he wrote up for this tablet, the 0x10 and 
> 0x20 values are reported by the right dial (left frame: 
> 02:f0:00:00:00:00:00:20:00:14, right frame: 02:f0:00:00:00:00:00:10:00:14). 
> Dumping the contents of data[frame->bitmap_dial_byte] yields the same result. 
> The left dial works like usual, 02 for left and 01 for right.
> 
> As for recieving reports of the two dials turning at the same time... I can't 
> seem to make it do that. This tablet is pretty big, and I can't turn the dials 
> fast enough.

Ah cool, then I guess we can remove the cases for "4" and "8"? I'd be
nice to stick with decimal numbers in all cases for consistency.
 
> > 
> > You can probably reuse uclogic_params_ugee_v2_init() or at least reuse
> > uclogic_probe_interface() and uclogic_params_parse_ugee_v2_desc() if
> > for some reason we need custom logic for this tablet.
> > 
> 
> I actually looked a little into the UGEE v2 init functions to see if I could 
> reuse anything (but to be honest, I really just skimmed) but I will take a 
> second look to see if I can consolidate it.
> 
> > 
> > Is this value 8? In all the models I have seen so far this is indeed
> > the number of buttons.
> > 
> > Also, what's the value of buf[6]? As you can see in
> > uclogic_params_parse_ugee_v2_desc(), this field is the frame type. I'd be
> > nice to know whether a different frame type is reported when 2 dials are
> > present or not.
> > 
> > Could you attach the contents of the 14 bytes of "buf", please? I'd be
> > nice to have a look and see if we can reuse as much code as possible.
> > 
> 
> Yeah here's the 14 bytes of "buf" here:
> buf[0] = 000c
> buf[1] = 0003
> buf[2] = 0030
> buf[3] = 00ba
> buf[4] = 009a
> buf[5] = 0068
> buf[6] = 0006
> buf[7] = 0000
> buf[8] = 00ff
> buf[9] = 001f
> buf[10] = 00ec
> buf[11] = 0009
> buf[12] = 0080
> buf[13] = 0072
> 
> I'm not sure you made a typo, but buf[6] in uclogic_params_parse_ugee_v2_desc 
> is reading the button count, which reports as 6 for some reason. buf[7] is 0 
> though, so it appears that its still reporting as UCLOGIC_PARAMS_FRAME_BUTTONS 
> (I could just be misunderstanding the strdescs) or the frames are completely 
> different.

Yes, my bad, I meant buf[7]. For the tablets I added so far it
indicated the frame type. However, it doesn't seem to be the case for
your tablet.

Also, buf[6] does not indicate the number of buttons (20?).

Did you check with Wireshark if the Windows driver is doing something
different for your tablet? It'd be nice to avoid adding quirks but it
might not be possible :S

We can ignore buf[12] and buf[14]. buf[0] indicates the size of the
descriptor (12), so the last two bytes are random memory.

> >
> > Ideally, we should be able to handle this tablet with the other UGEE v2
> > tablets.
> > 
> 
> Yeah I will consolidate this case if I manage to merge this with the other 
> UGEE v2 tablet support.
> 
> > 
> > This array is already declared in uclogic_params_ugee_v2_init(), which,
> > hopefully, we will be able to reuse. Otherwise, you might be interested
> > in this commit (not merged yet):
> > https://lore.kernel.org/linux-input/20221226125454.16106-4-jose.exposito89@g
> > mail.com/T/#u
> 
> I didn't see that array in ugee_v2_init, what I'll do is match the variables 
> defined in your cleanup patch (I believe it's closely identical already), so it 
> makes rebasing easier no matter what order they're merged in.
> 
> > 
> > Can't "uclogic_rdesc_ugee_v2_pen_template_arr" be used instead?
> > 
> 
> Yeah I think so, at first I didn't consider it but on closer inspection - the 
> offsets are the same (just for some reason, out of order). I'll be looking into 
> testing the pen using this descriptor on the second revision, maybe Pro-series 
> and UGEE v2 aren't so different after all!
> 
> > 
> > Have a look to "uclogic_rdesc_ugee_v2_frame_dial_template_arr", I don't
> > know if it could be used for your tablet.
> > 
> 
> Same as above, same structure - different order (but it's all semantic, same 
> offsets) so I'll be consolidating if it works out.
> 
> >
> > If your tablet reports its number of buttons, UCLOGIC_RDESC_FRAME_PH_BTN
> > can be used here.
> > 
> 
> I'll be reviewing the descriptor data, ideally it should but I don't have high 
> hopes (as shown above) but I'm going to be testing it more.
> 
> Thank you for the review! I'll be resubmitting a second version of the patch 
> with your suggestions and making sure the kernel test bot is happy - and 
> hopefully there will be a lot less duplication structure-wise.
> 
> 
> 
> 
