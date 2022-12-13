Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277564B8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiLMPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLMPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:39:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F02F8;
        Tue, 13 Dec 2022 07:39:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764EB615BA;
        Tue, 13 Dec 2022 15:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6210C433D2;
        Tue, 13 Dec 2022 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670945968;
        bh=BikuhlLcpULmvZ8vJt/sfoYfKYoTYubOFmvQ+RZ8I8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maU9wZozhg3uL6XAEm/N2Eywax2RDrQwVvOnAcemENR+QvPeD/jWbLc+Xb9l5mQH+
         o/rCi5Q5h45hZI3daVO10gVXHzuLyR3DXW5K3pVrPVigGZGdZFrzes3XZc/vGsGouN
         oRhIo5cUc7qQB2LjwEy+1cchdGvRHChR8KpqfOKWre3T9FM+kMxp0JjaYO7Eh4zMNV
         B971xV7cAimFrxeBtJYXi9uZ/gF4DBhfkZ2b7J6yhWXHfBmbOkYEYa3XG+NuO46Anp
         ZtJ01XcmWNThrIj2p4gWXpT3jbcyEWT4ZQUWjbtOXjiVYKiG/3LRzTZO96TvcBlVaA
         6AP8z3WJop4KQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p57Nq-0005M0-Pa; Tue, 13 Dec 2022 16:39:54 +0100
Date:   Tue, 13 Dec 2022 16:39:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5icyo7I5ZGAL02q@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iWeTk2zOp9rInx@x1>
 <Y5iaDP+nV9B59U2b@hovoldconsulting.com>
 <03252ccd-e200-a112-b4dd-ba9fbf25c480@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03252ccd-e200-a112-b4dd-ba9fbf25c480@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 09:04:39PM +0530, Shazad Hussain wrote:
> 
> 
> On 12/13/2022 8:58 PM, Johan Hovold wrote:
> > On Tue, Dec 13, 2022 at 10:12:57AM -0500, Brian Masney wrote:
> >> On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> >>> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> >>>
> >>> That is, the QUP nodes are labelled using two indices, and specifically
> >>>
> >>> 	qup2_i2c5
> >>>
> >>> would be another name for
> >>>
> >>> 	qup_i2c21
> >>>
> >>> if we'd been using such a flat naming scheme (there are 8 engines per
> >>> QUP).
> >>>
> >>> So there's nothing wrong with how these nodes are currently named, but
> >>> mixing the two scheme as you are suggesting would not be correct.
> >>
> >> Hi Johan,
> >>
> >> What would I use for the name in the aliases section? Right now I have:
> >>
> >>      aliases {
> >>          i2c18 = &qup2_i2c18;
> >>      }
> >>
> >> So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
> >> the alias like so?
> >>
> >>      aliases {
> >>          i2c18 = &qup2_i2c2;
> >>      }
> > 
> > Or perhaps the i2c controllers should use a zero-based index instead of
> > being named after the serial engines (e.g. as we do for the console
> > uart).
> > 
> > How are they named in the schematics?
> 
> We should use from 0 to N.

With N being 23 after the number of serial engines, or the number of
available i2c buses on a particular board minus one?

Johan
