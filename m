Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBC66C9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjAPQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjAPQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:56:26 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8377B234FB;
        Mon, 16 Jan 2023 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aUfB3AF4nSnEWuFAKrrl7ICheJD0YUl7P76ByMRbEYU=; b=gWpw/iRVfritEd7h9I0VYTsRts
        Pt+UqPSVw1cVATq5UKrqZBOl0bjT5uWHCNj/VfHm72DCKOC/m7q/JUJ83u/ws66Nv+/eT5QjynwMj
        7vavDb+mgGEWti57FzuH+9eiWiGjCrNY2rtNrLhgAuEXgbQEwzBI+8sQcHUMWk6bpZsMaFOREDhEA
        9SAU59KB2PK4fnMbb2XZER0GBQS9xuJY26CdR0XD8nhjbrLJJ3TG6qWaPz2v/m8o1TZ/q7bYrCDrd
        SRt0HjFfbt813wHxdPGqptYnWYcKjhYDsiP+yc6dt/81tA0ehJ2SuRhuj+yR/0m0iFF5IwzPyd7kr
        RuSpQd+g==;
Received: from p200300ccff0748001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff07:4800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pHSW3-0003GR-K8; Mon, 16 Jan 2023 17:39:23 +0100
Date:   Mon, 16 Jan 2023 17:39:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adam Ford <aford173@gmail.com>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <20230116173922.585904bf@aktux>
In-Reply-To: <Y8VkjQ2yZQssx/wJ@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
        <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
        <Y8VkjQ2yZQssx/wJ@atomide.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:51:57 +0200
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Adam Ford <aford173@gmail.com> [230116 14:16]:
> > Would it make sense to make this default in the omap3.dtsi file and
> > enable them in the individual boards that need it?  
> 
> In general disabling the unused devices by default for omaps will break
> the power management. The disabled devices are completely ignored by the
> kernel, and the devices are left to whatever the bootloader state might
> be.
> 
hmm, shouldn't ti-sysc keep things disabled in most cases? It is still a bit
known because there is no status = "disabled" in the target-module@xxx node.

Regards,
Andreas
