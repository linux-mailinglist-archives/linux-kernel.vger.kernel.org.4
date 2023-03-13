Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB36B7DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCMQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCMQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:45:38 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817131F49B;
        Mon, 13 Mar 2023 09:45:37 -0700 (PDT)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Pb2b33L6sz4BKKQ;
        Mon, 13 Mar 2023 18:45:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678725935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09Kna67nVseHs09S+p/lfcaEE+UDENKEBFM4ppU3O54=;
        b=g+NbnJdEYI7DTohf+uiRvJwnn4Ajcfm3Ki8xt8u9qeFZDC9HCw4yt2kYhMR9BDa/1TpQYA
        MAXNZxflVEBZYN3fGFZopj+nmbxolaSJowZkcZuTiRWyOAjyuUp353BfBjJTP/d9LwYWFN
        RVs/g5FXzE1Q5BjA6eEfI4arhvo+9drCsAli+cBpNsWjv33MHUWLkPyOrAs8gxeIR/pZCP
        WjOmhUbxTBLFlDcU891Dtxt22I1YToSDawmzzbV7wOzULOV5//11IYEn528nQAQkExLC1f
        NzfC3ZsoVTGtmhDekDf7KW/cvhYqqHf4fcWsnI5LKM1MZC3LXk/irOpqlzYLQg==
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Pb2Zs43VMzyd2;
        Mon, 13 Mar 2023 18:45:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678725928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09Kna67nVseHs09S+p/lfcaEE+UDENKEBFM4ppU3O54=;
        b=ai5fepUEvCxWwNXpPa33iwFrh8MjZE3W+7kr7QvsybpGa0eH7dOhRwHCBAnxx19H0q5rqZ
        nHVLweGoWlyhc65ScP/w8g+6ImTYY+x2vHlz22Xv2VQO4rr/QbZZm1F+q0CgxWnNKd+13P
        bfijnEK0CaaPG19Rce1idCjfekR/Bhk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678725928; a=rsa-sha256; cv=none;
        b=NtMpv6469vL4zn+gQbcpfDWA5+XVDSauvdi/UjZSwmF28MsKg6y89o4dvH48FtzGTthUq4
        t2pCmqtlLJxG4ynf5FP56tUH1bXrR6UCWdcsBYTx6/K8OnkBcq5BDcAxreRokzPGbq6CWY
        XdOiTGmJkGADdQLUJadugeo14VR3afg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678725928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09Kna67nVseHs09S+p/lfcaEE+UDENKEBFM4ppU3O54=;
        b=FBL7TqR8aL8NgsJby5zCL955cu5hWTrJsQuOrCF5sE+v4InZv7sdKo4fZToSX08RxdFgsA
        NqDFwUqMkQAG7sOzpThejpgBDu7VqOCm1Bf+1XHeQNGwXYzgGNZ3IkObBqMP0lPsgqdMvH
        TqXa3mF95J/4vdZ25fFlumUJI1ce/bA=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 69F52634C91;
        Mon, 13 Mar 2023 18:44:27 +0200 (EET)
Date:   Mon, 13 Mar 2023 18:44:27 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/7] media: dt-bindings: samsung,fimc: convert to
 dtschema
Message-ID: <ZA9S62I1mTedUYSv@valkosipuli.retiisi.eu>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
 <20230216142204.48394-7-krzysztof.kozlowski@linaro.org>
 <ZA8YJx+NE0+89YaD@valkosipuli.retiisi.eu>
 <ZA8v98mqm4Xdt2Sl@valkosipuli.retiisi.eu>
 <85bbec87-992d-f9a9-2f2b-bc41457933bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bbec87-992d-f9a9-2f2b-bc41457933bb@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Mar 13, 2023 at 03:28:15PM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 15:15, Sakari Ailus wrote:
> > On Mon, Mar 13, 2023 at 02:33:43PM +0200, Sakari Ailus wrote:
> >> Hi Krzysztof,
> >>
> >> On Thu, Feb 16, 2023 at 03:22:03PM +0100, Krzysztof Kozlowski wrote:
> >>> Convert the Samsung S5P/Exynos Camera Subsystem (FIMC) bindings to DT
> >>> schema.  Changes during conversion - adjust to existing DTS and Linux
> >>> driver: add iommus and power-domains.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >> This does not apply on top of -rc1.
> >>
> >> ...
> >>
> >>> -- compatible: must be "samsung,fimc"
> >>
> >> I guess you have another patch removing "simple-bus" here and another
> >> location in your tree?
> > 
> > Ah, what's missing seems to be this set:
> > 
> > <URL:https://patchwork.linuxtv.org/project/linux-media/list/?series=9839>
> 
> Yeah, dependency is mention in cover letter.
> 
> > 
> > But also the second patch of that set doesn't seem to apply. :-(
> 
> Yep, I forgot I already sent same patch two months earlier. Let me merge
> two patches, rebase and resent, so everything will be easier for you
> (hopefully). Sorry for the mess.

No worries. I was expecting a comment from the author but never saw one...

Thanks for refreshing the set.

-- 
Kind regards,

Sakari Ailus
