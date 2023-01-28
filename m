Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970F67F6ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjA1KLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1KLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:11:18 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F14204;
        Sat, 28 Jan 2023 02:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674900667; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VSJ5jhoFmwRt6mwbgwzzTzR8DjBR5p8+DOYP8WNOEkcm9BHJlkQKHXOyr0iWJeLNfd61eBohoxitQvQuMCSf50AkyGX6wRnB3dw5smVCu2eQQB6Qkaw5PWV3Evq1Up6W/Q6o6M5xPN16jMs/nnY69yw02/rgbF994a4pcAY5Q0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674900667; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rx+uLL3mqAm2YhJKP6yaEQTNuLfDMRHXbkMZRQ4m12Q=; 
        b=SEBSOYC8ssuwikYCJNILYIIW+u7KZx7aBFwlEuGzeAVHWrFfI2hFpXLKt9kARU178dN57yUw3H2zhxPx3fnxd2ktvWjAT7ih3ttiy1lZzhNUeiWBN67tGNQMC6ZfsxkbpNS8NadnKI1ynolfWS1HbVLJIEezEd/9ojwzS9/qg1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674900667;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=rx+uLL3mqAm2YhJKP6yaEQTNuLfDMRHXbkMZRQ4m12Q=;
        b=MjH01jynO0D2Nlct1akC7qBRR1533tdLlmo8R7mIx6VjQzMzQusF9+nj4Fo9Oyon
        NhyRB8/k9cQdKGBsNY7I8G/B6ojXxulUGMc8l2MOBtgAEhap+QIFpghP2n6vhUjeWPx
        33OtwmZ2bEaaXzjN6h3GxJtJr9aHiFFqWdd61Z+o=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674900666640396.7756550313784; Sat, 28 Jan 2023 02:11:06 -0800 (PST)
Date:   Sat, 28 Jan 2023 18:11:06 +0800
From:   Li Chen <me@linux.beauty>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "stephen boyd" <sboyd@kernel.org>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "arnd bergmann" <arnd@arndb.de>
Message-ID: <185f7dbf8f4.1146e435a489984.6909631260982981609@linux.beauty>
In-Reply-To: <04b409b7-0d8c-4b60-1fd5-3486f47cc04c@linaro.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
 <33c2038b-5e06-4eb2-82b8-007bb735bfb1@linaro.org>
 <185f7c1c693.b1cad2b8487563.1022046142491625830@linux.beauty> <04b409b7-0d8c-4b60-1fd5-3486f47cc04c@linaro.org>
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

 ---- On Sat, 28 Jan 2023 18:08:00 +0800  Krzysztof Kozlowski  wrote --- 
 > On 28/01/2023 10:42, Li Chen wrote:
 > > Got it, I will model it as:
 > > 
 > > rct_syscon(compatible include "ambarella, -clock"...)
 > > | peripheral A
 > > | peripheral B
 > > | ...
 > > 
 > > 
 > > One more question, two driver models:
 > > a. compatible = "ambarella, -clock", handle all clocks(pll, div, mux, composite) in single driver.
 > > b. compatible = "ambarella, -pll-clock", "ambarella, -composite-clock", "ambarella, -div-clock"...... 
 > >     and implement a driver for each of them.
 > > 
 > > Which driver model is preferred?
 > 
 > We do not talk here at all about drivers. This is independent and not
 > really related.
 > 
 > Anyway, independent features mostly have separate drivers. Each separate
 > driver should be located in respective subsystem. But again - we do not
 > talk here about drivers at all, so please do not bring them into the
 > problem. It will make everything more complicated...
 
Ok, that makes sense. Sorry about that.

Regards,
Li
