Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888B5E6365
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIVNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiIVNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:16:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E16ECCC5;
        Thu, 22 Sep 2022 06:16:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so13580490edj.3;
        Thu, 22 Sep 2022 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1tCfC9m4QH6+svhoWCBlzPrI1dXMxInAC29KGFvnwaE=;
        b=UVhWHt7woG/lbkeJsRqO6Va2XTivmTiPxQDOlJWr6pjRcRUe7gjDSW9ANpMlPFIeYn
         zc4C0FXYlaxgirQofxv9lC3cTaMjD664dIjA0/19AiErOjMlrwcg7QTWuP9LO2cvP43Z
         DeVtD2fJnzR8wXTnIc8FyKSJPtVnh1TIs5ISVSBY3PY+DPPGqkJ/xKzST5g1fCryVnkw
         8fCAQugL4DYjI2kYi71k5R/OgZN/KEBmbx4KEymMXjekKb4a0suKJUr2MRisQpGL0NPP
         v3EIYZ8HK9Qp/N4uPYGoZDk4IubPD0H338lXI1wUFKisy2BDPOtEfBTfn8W5TEL9f2eF
         Pt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1tCfC9m4QH6+svhoWCBlzPrI1dXMxInAC29KGFvnwaE=;
        b=O0P8dcG/VmDelFa3XRMvhWlXlAQGja5UOPrUNXtVzfGEJZsOsPX5qQEoO89kdeB3Gj
         8X/VsTvf2AvS/OuniKQLrjfkqIydOrD60P0JTMlOOUY3v/mFBhjenc+WXvUz9dCeGp46
         IVJrh/pmSSieH/5k0CzjYbyVz3d4ex8X8FjWuzKGcgz3/rZf+L9d0DibJv39pf5Gk846
         JL0oDQGq0ATDNJXvvGjZRqZANtgTnxF60Um0TZZzzL5TdNQzjzlVsBDeheKlHjlm+nf3
         tZd2WMDeE8Je02kwq9M/WR+yywb7XAZ8zBxhurUfGCXBkZGG5YBtDPH+M+fTy97UVtQ2
         wwEw==
X-Gm-Message-State: ACrzQf1dEbm5I/s7oTxeI6bZokAaURYHUu4HSUFvbZvOJi/MCJiGLIq+
        eFo+zrmGKXk5wbZ9KOO1072jeJPyLESfPosave4=
X-Google-Smtp-Source: AMsMyM6PwI+XDb8FHnWsV5Jg87oihIis/34mBej0cDXL8E8il1hHVobmCPbm4FGrkYWdqrywN1xkffmN4CJwt071IaA=
X-Received: by 2002:a05:6402:f11:b0:44f:e1ff:801a with SMTP id
 i17-20020a0564020f1100b0044fe1ff801amr3307570eda.109.1663852602418; Thu, 22
 Sep 2022 06:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyuDoaewe4AQBdsF@paasikivi.fi.intel.com> <CA+V-a8sa+gEwyGRNqbz04BZ3ZtGkokJn9YrZ+U5q0VcY1BDKSA@mail.gmail.com>
 <YyxczbcHWF47FL8/@paasikivi.fi.intel.com>
In-Reply-To: <YyxczbcHWF47FL8/@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Sep 2022 14:16:15 +0100
Message-ID: <CA+V-a8v3JfU+_Ut9oxmKfK5iQ-LwZhEYPr5HQ0-M+_iQ_42xmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Thu, Sep 22, 2022 at 2:02 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 22, 2022 at 01:53:49PM +0100, Lad, Prabhakar wrote:
> > > > +int rzg2l_csi2_cmn_rstb_deassert(struct rzg2l_csi2 *csi2);
> > > > +int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on);
> > > > +void rzg2l_csi2_mipi_link_setting(struct rzg2l_csi2 *csi2, bool on);
> > >
> > > Are these something that could be achieved using the standard interfaces,
> > > as I believe the other drivers are doing? The pre_streamon and
> > > post_streamon callbacks could be relevant for this.
> > >
> > Thanks for the pointer. I have now moved some code to pre_streamon ()
> > and rest to s_stream(). Is there any mandatory rule to have both
> > implemented? (as I wont be needing post_streamoff(), nothing complains
> > so for)
>
> In principle no.
>
OK.

> But if you e.g. resume the device in pre_streamon, you'll need to suspend
> it in post_streamon.
>
Agreed!

Cheers,
Prabhakar
