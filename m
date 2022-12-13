Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB664B862
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiLMP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiLMP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:27:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E308E02D;
        Tue, 13 Dec 2022 07:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA43A6159C;
        Tue, 13 Dec 2022 15:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2149C433D2;
        Tue, 13 Dec 2022 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670945266;
        bh=a0Ky+b1yMjswt+iTbryaG/vZoF6bspH9STJwFhUcNYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqPdcvRHXpJ4Z39oY2TO8anY6i0ORgZigyUmsjEZAukgyQ+mdBXnIuvG6h95BvJx/
         ZHkcWwnPa3GAf0XuDV62/vH+dwsS8+aR+Sly3JiL1Hg2nzxjODVd/2agKC24Pq5CIh
         6lNsHbRNFBMO4TWA71eu74MLu3sV4vFcHvQPheDZsseo9PsHcIq7VjMZtAuOw7dLKm
         zMvb6ww2Kmj5oaXso6aqJqEsYJGYdA9qYUvyBTKHZUuVQ8HtOlA7dlKAuqHG927YRv
         a5fo5Y/xG7aDfPBmwuL7PxWemhPM42kzeAC7qslrmGMsDweEAwnHEKSwpI2kzISS42
         nxPbNzuFQYf2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p57CW-0005DO-4B; Tue, 13 Dec 2022 16:28:12 +0100
Date:   Tue, 13 Dec 2022 16:28:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iaDP+nV9B59U2b@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iWeTk2zOp9rInx@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iWeTk2zOp9rInx@x1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:12:57AM -0500, Brian Masney wrote:
> On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> > Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> > 
> > That is, the QUP nodes are labelled using two indices, and specifically
> > 
> > 	qup2_i2c5
> > 
> > would be another name for
> > 
> > 	qup_i2c21
> > 
> > if we'd been using such a flat naming scheme (there are 8 engines per
> > QUP).
> > 
> > So there's nothing wrong with how these nodes are currently named, but
> > mixing the two scheme as you are suggesting would not be correct.
> 
> Hi Johan,
> 
> What would I use for the name in the aliases section? Right now I have:
> 
>     aliases {
>         i2c18 = &qup2_i2c18;
>     }
> 
> So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
> the alias like so?
> 
>     aliases {
>         i2c18 = &qup2_i2c2;
>     }

Or perhaps the i2c controllers should use a zero-based index instead of
being named after the serial engines (e.g. as we do for the console
uart).

How are they named in the schematics?

Johan
