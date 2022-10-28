Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02C0611C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJ1VFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1VFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:05:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A041CEC0C;
        Fri, 28 Oct 2022 14:05:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so15778004ejd.9;
        Fri, 28 Oct 2022 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pmg59QEvCvB7YDZ5n3GJNoCUMN1VloPth+aIiSQIEsA=;
        b=pawWAwhqMyDCLnAVREPTezgYxlot5ZLzUpBs82QzdJOwckdBUMPBSiWgoIgUWa6fOJ
         bIkM+9IKt8z5zMWOfkqWC62e9jD9hPznmpZAiF3Z92MZeXjZ2EXdp79mQFBCVVKX5RHA
         d2+zNLKJGhTS2ZdBMoMOC3imBv8nkKsrN3MK3CQ6+UkRqm3/aNDa95JS30+KbnxYRv0I
         ZRpzqO4bUs5sp2EoczKmCzdTqoi0W8aA3bAe8P19r7+WOjoga/3Q1KJpuX2TrSLngx4P
         3YOqmp/4U7VJu2FpNwNJ5OSnzfiqISZTaXfAdz3kbaDigz3pxNYlsXc5UJu5iSmCMXFf
         TjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pmg59QEvCvB7YDZ5n3GJNoCUMN1VloPth+aIiSQIEsA=;
        b=SfXKwpz1NAfJPACS4cvPk66RBifzVMAK6MdiMt1UJJoZSaf3FRpS/FAcAnkymSre0F
         Lyi87WHJdhnF0ADB8Gfkk8gAOGJ78xUJSQ/P62CI4lMc4yO0mla0r1yIdOLOrWx/E/6w
         VXHrAOteHPs2Q2o8tIzQTP4ZIMWUZgTFz0yle4vz0Css63chFoeETxfNEp5LswAxEQdz
         7UT5APXcvIAlatD84cMLq/6Pa0+itpxvbQ1ukFNGWIPy8U1016iE6fe4NA7Imjq2wDY7
         mcl3hI3HUa9P24ruHkojV9ivCxWhzS7lGC4nXGsb7euZ8fFowu5ZSuCAf+Zi1aNZOTJO
         Kafg==
X-Gm-Message-State: ACrzQf1+MpkBw23tAVrDvLuzvMbSh3KAmYvcxb2ml9wdPD1u2hV1qRde
        9Yh0MmjXggrUqmuHRzV+gvUiPSH5wJdB4BUwxhw=
X-Google-Smtp-Source: AMsMyM75Y5FZ82YEH9D4k42+Gt58baqs7YVwanOze6jxdEHQSjcNXVZn9yXWnEE31Trw2DPx1IUYVmLsER+xQW6KzNU=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr1129553ejc.447.1666991127780; Fri, 28
 Oct 2022 14:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com> <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
 <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com> <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
 <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com>
In-Reply-To: <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 28 Oct 2022 22:05:01 +0100
Message-ID: <CA+V-a8urGG-m-gn_sOhTJHhHws3X8zdgjq+YY8W7qy42VAdXgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Oct 27, 2022 at 7:45 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 27, 2022 at 05:32:07PM +0100, Lad, Prabhakar wrote:
> > Hi Sakari,
> >
> > On Thu, Oct 27, 2022 at 1:47 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> > > > Hi Sakari,
> > > >
> > > > On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Prabhakar,
> > > > >
> > > > > One more comment.
> > > > >
> > > > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > > > >
> > > > > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > > > >
> > > > > > +     pm_runtime_set_active(dev);
> > > > > > +     pm_runtime_get_noresume(dev);
> > > > > > +     pm_runtime_enable(dev);
> > > > >
> > > > > You won't gain anything by eanbling runtime PM here. Just move it to the
> > > > > end of the function before the rest of the calls. Error handling becomes
> > > > > more simple.
> > > > >
> > > > If I move the above calls below I get the below warning:
> > > >
> > > > [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> > > >
> > > > This is because of the last patch which moves ov5645_entity_init_cfg()
> > > > before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> > > > due to which we are seeing the above message. Please let me know how
> > > > to proceed on this.
> > >
> > > Ah. Yes, this is a problem with the usage pattern of
> > > pm_runtime_get_if_in_use(). But please don't change that.
> > >
> > > You can still move enabling runtime PM later in the function.
> > >
> > Agreed, the final version looks like below:
> >
> >     pm_runtime_set_active(dev);
> >     pm_runtime_get_noresume(dev);
> >
>
> You'll have to enable runtime PM here, before pm_runtime_get_if_in_use()
> gets called.
>
> I'll see if it could be made to work in a sensible way when runtime PM
> isn't enabled yet.
>
Agreed, I'll send out v3 after fixing the comments.

Cheers,
Prabhakar
