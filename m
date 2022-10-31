Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E380613B02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJaQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJaQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:11:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7367DF61;
        Mon, 31 Oct 2022 09:11:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 21so18166550edv.3;
        Mon, 31 Oct 2022 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCzM+z8lbU3sUbT7i4WqD5Kg67j9Dyb20Cc1XCa8sRM=;
        b=qKqmZWqo0DkJvx0vYCMHgc8guzN8iVhj59dDHl16HPXO4yL9xeYSfmTVB87fLCXkds
         /q0gAMJ3hYKLh/JC2740UsBREiIvBWInMT8We1fJapvSCu2k9WvdFpDG5O16LMPH/qYC
         u8Ia8txchf1OK2lP0+LYcYa0PvD3EMSyJVkgrf85D7gQ1lTdgbzTVbqOWi6llu9mJSKe
         5BlUQSGfj9enWi8ecWCwMouY5FFuqy45snE6um9sh/TJPGfu+yCS0C8IGRKjyUSapizZ
         ARgl3abqhJTrr8ctR/z8vuF06gMSFbZ7EEgNrzrQtZwvlmb4ObZ02BI07zvN7zCpefQo
         ouxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCzM+z8lbU3sUbT7i4WqD5Kg67j9Dyb20Cc1XCa8sRM=;
        b=xr7jQ3+3JNkpmGtbQBzhpgP3CXS4mCyeYFVPyqjYdyQ75yQTvWTzpye68cbp3ri/yD
         uNVEzAMsi3wF7jdCz5YveWZ4U5bXOEcM287pYUD881kzLHbO45Drg+X0b0BJC/umin9Z
         fwBAzTzoULKYqjVClzp+m3Fqj/rpsyq1A4b5/2PosI64BvV2S6Wj6gSNTPIR3OtQoTHe
         VSozrosLBydiIn0SLRDNOY+RvFWBCE4hUbfny0oh6keqRf4JpqddzDLAFAEx4ASYU4O4
         dbTzt8XKNn6YwNVwqL2kcmkBbS8PRzyPILPnh1HbjGgBc25orKZcj7h2eNjzJOoozM4m
         o16A==
X-Gm-Message-State: ACrzQf3Q42wwpCizkIJGsQsB+8gKqQwoTk7DXzpZpZyqTXMdp+04WXlB
        xyydiqOf64WeEVRFr7AFquQJXaFB/SiuPdsEaOo=
X-Google-Smtp-Source: AMsMyM6PFq7Zt3THHm08ReMXUZEYl5HsciKAwxHOZtB+/CwtOnuYr2XqM5HB9OrJs8TZ9T7qLnN4DLpUwpo8LGtnLQA=
X-Received: by 2002:aa7:de0a:0:b0:462:d2a0:93a with SMTP id
 h10-20020aa7de0a000000b00462d2a0093amr13865340edv.275.1667232672211; Mon, 31
 Oct 2022 09:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com> <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
 <Y1p91+XxPCB9NWwh@paasikivi.fi.intel.com> <CA+V-a8uhYymEVg7jdLVGNLsVD3=O1mk-_NVERu00W+gsv-7QXg@mail.gmail.com>
 <Y1rQBmXj71C1RrwB@paasikivi.fi.intel.com> <Y1/a4QUQpykhuXwh@paasikivi.fi.intel.com>
In-Reply-To: <Y1/a4QUQpykhuXwh@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 31 Oct 2022 16:10:45 +0000
Message-ID: <CA+V-a8vQkvO5k=b169SfiD5qdn9hNOJk6y2GHns1OkrnxHXeXQ@mail.gmail.com>
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

On Mon, Oct 31, 2022 at 2:25 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 27, 2022 at 06:37:58PM +0000, Sakari Ailus wrote:
> > Hi Prabhakar,
> >
> > On Thu, Oct 27, 2022 at 05:32:07PM +0100, Lad, Prabhakar wrote:
> > > Hi Sakari,
> > >
> > > On Thu, Oct 27, 2022 at 1:47 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > On Thu, Oct 27, 2022 at 01:01:52PM +0100, Lad, Prabhakar wrote:
> > > > > Hi Sakari,
> > > > >
> > > > > On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Hi Prabhakar,
> > > > > >
> > > > > > One more comment.
> > > > > >
> > > > > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > > > > >
> > > > > > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > > > > >
> > > > > > > +     pm_runtime_set_active(dev);
> > > > > > > +     pm_runtime_get_noresume(dev);
> > > > > > > +     pm_runtime_enable(dev);
> > > > > >
> > > > > > You won't gain anything by eanbling runtime PM here. Just move it to the
> > > > > > end of the function before the rest of the calls. Error handling becomes
> > > > > > more simple.
> > > > > >
> > > > > If I move the above calls below I get the below warning:
> > > > >
> > > > > [    2.633386] ov5645 0-003c: Runtime PM usage count underflow!
> > > > >
> > > > > This is because of the last patch which moves ov5645_entity_init_cfg()
> > > > > before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
> > > > > due to which we are seeing the above message. Please let me know how
> > > > > to proceed on this.
> > > >
> > > > Ah. Yes, this is a problem with the usage pattern of
> > > > pm_runtime_get_if_in_use(). But please don't change that.
> > > >
> > > > You can still move enabling runtime PM later in the function.
> > > >
> > > Agreed, the final version looks like below:
> > >
> > >     pm_runtime_set_active(dev);
> > >     pm_runtime_get_noresume(dev);
> > >
> >
> > You'll have to enable runtime PM here, before pm_runtime_get_if_in_use()
> > gets called.
> >
> > I'll see if it could be made to work in a sensible way when runtime PM
> > isn't enabled yet.
>
> There are various ways how runtime PM interface functions generally work,
> and generally return an error when runtime PM is disabled. Incrementing the
> usage_count when runtime PM is disabled would make
> pm_runtime_get_if_in_use() very special and not match what the rest would
> do. Therefore I think it's best to keep this in the driver. After all, mo
> other driver needs this in the media tree, which is the major user of the
> function.
>
Thank you for digging deep into this. I'll keep it as is and send a v3.

Cheers,
Prabhakar
