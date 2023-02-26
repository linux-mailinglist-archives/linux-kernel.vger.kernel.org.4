Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AC6A3327
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBZRW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBZRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:22:55 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7A6A6F;
        Sun, 26 Feb 2023 09:22:54 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id u6so2742602ilk.12;
        Sun, 26 Feb 2023 09:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZbAAW2LhN0XjJxVgdRFWlox+ztnO/qtqmkajxnI7Dg=;
        b=Im4x4EimTu9GcNtjRJ7FX4LJocaZuegbcrS1QFth8yrWw5CD7p7tfVGA75uIz9Boe8
         68yzAOd45eBHPXD71xGE9bdM/pWfzDpYEtd2uVkRRwT0Jml03tzEQT/py7/IQ4ARE4qP
         tJ1d9xTb5r7AL2i/W3t+ZVVe7MVawQobhcOFNzvqJg/6vV1TVFdde7LFa86H4XOGuWIC
         l1Xz0O96Az61NNVNNlS48E1smo9wn8Y3LLS0W7/Wxt8XvXFIW3p4Ob2MdqhHR8nijKb9
         NsAlQtkwHKcGQTtBqWbhYZBWlzSrt/denZL87J3AnywN3PH1bS2ZfcNmZPtwwLsDux3B
         a6hw==
X-Gm-Message-State: AO0yUKXLxNgGYc+4mifLY7v/vWbELVyHZSOQIF2JBDeHupsuxJngoleG
        Ny+oAvJZTyIgAwOSwEPhCQ==
X-Google-Smtp-Source: AK7set9Ei4vkCXLk+pyPw9tD9bTD0a5PZqFdVS5ekfmJqFXIZlbAF/z0U2hZkghLu9Q/2ShzJ1RSzg==
X-Received: by 2002:a05:6e02:18cf:b0:313:dd5c:e55f with SMTP id s15-20020a056e0218cf00b00313dd5ce55fmr4986365ilu.6.1677432173112;
        Sun, 26 Feb 2023 09:22:53 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id f17-20020a92cb51000000b003141b775fbasm1413045ilq.16.2023.02.26.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:22:52 -0800 (PST)
Received: (nullmailer pid 49214 invoked by uid 1000);
        Sun, 26 Feb 2023 17:22:48 -0000
Date:   Sun, 26 Feb 2023 11:22:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Andrew Davis <afd@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <20230226172248.GA47940-robh@kernel.org>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
 <20230222203847.2664903-2-colin.foster@in-advantage.com>
 <dd67f7c9-0867-47d0-a201-9316908d9d62@ti.com>
 <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 08:25:08AM -0800, Colin Foster wrote:
> On Thu, Feb 23, 2023 at 10:00:50AM -0600, Andrew Davis wrote:
> > On 2/22/23 2:38 PM, Colin Foster wrote:
> > > Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
> > > the Phytec PCM-959 development kit.
> > > 
> > > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > > ---
> > > 
> > > v4
> > >      * New patch, based on a WIP from Andrew Davis <afd@ti.com>
> > > 
> > > ---
> > >   .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
> > >   1 file changed, 29 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
> > 
> > How will this work if I add the same file? Why not take my WIP patch, make
> > the suggested changes from Rob, then have it as your first patch in this
> > series?
> 
> Is your WIP intended to convert all omap.txt to ti,omap.yaml? Or chunk
> off devices one at a time?
> 
> If the former, when your patch is done it should be a pretty simple
> rebase conflict resolution. If the latter (which feels more digestable)
> this offers that template. This was Rob's / Tony's suggestion, albeit
> before you sent your patch set.
> 
> 
> Anyway, I'm happy to do any of the following:
> 
> 1. Take Andrew's patches, add these references and re-submit.
> 2. Keep this set as-is (with the typo fix) and when Andrew's WIP is done
>    it should be an easy rebase before submission.
> 3. Wait for Andrew's WIP to be done, then submit with this update.
> 
> 
> I'd like to avoid #3 because I don't know where this might fall on your
> priorities list.

If you are willing to do #1, that's certainly my preference.

Rob
