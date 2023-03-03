Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12856A968E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCCLj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCCLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:39:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001623659;
        Fri,  3 Mar 2023 03:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C527B818A6;
        Fri,  3 Mar 2023 11:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E60C4339E;
        Fri,  3 Mar 2023 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677843590;
        bh=I67wD2VPLvWn6k0HOQ0HyWEMmVsne14JmWKz+mBqvIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTkY9eXMB5r/ml0duVnEYUUCqH0mVYY/zdj1H0njOjVTkYPBqklKDEf0gq3XTzGdr
         r+2IJjp23XkT5yNUBwrcdLtFzL7XnKVDp3KFPprMP5fiafUkZ4YFiuySHc9VR9lP2L
         Gvx2mfl/TpOQ1QQOu9u2qFOw225zCOi1lKcOuADzB2FrPoJ8GiKBWKy5mz44oVJPBD
         fKdL1cCcwvgmotXrD+yVEz4FUX5COcuNCH47ZSkeQsEgbwDtOk0kKLAJ6L1A2xUWmo
         MwxikzdP50zEvZFQWIgfhtL6jtm6nV1nOHGpP05ua/9diiq6emMyU2IkT/M6Om60wF
         eyMGzcqHBk64w==
Date:   Fri, 3 Mar 2023 11:39:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v6] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230303113945.GF2420672@google.com>
References: <20230213072133.5977-1-manivannan.sadhasivam@linaro.org>
 <20230303103407.GR2303077@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303103407.GR2303077@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2023, Lee Jones wrote:

> On Mon, 13 Feb 2023, Manivannan Sadhasivam wrote:
> 
> > Document the commonly used LED triggers by the SoCs. Not all triggers
> > are documented as some of them are very application specific. Most of the
> > triggers documented here are currently used in devicetrees of many SoCs.
> > 
> > While at it, also place the comment above the triggers (hci, mmc, wlan)
> > to match the rest of the binding.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v6:
> > 
> > * Rebased on top of lee/for-leds-next branch
> > * Fixed the comment location for few triggers
> > 
> > Changes in v5:
> > 
> > * Rebased on top of v6.2-rc1
> > 
> > Changes in v4:
> > 
> > * Removed the sorting of triggers
> > * Removed the "items" as they were not needed
> > * Reworded the description
> > * Dropped Zhen Lei's tested-by tag as the patch has changed
> > * Added kbd-capslock trigger
> > 
> > Changes in v3:
> > 
> > * Rebased on top of v6.1-rc1
> > * Added WLAN Rx trigger
> > * Added tested tag from Zhen Lei
> > 
> > Changes in v2:
> > 
> > * Added more triggers, fixed the regex
> > * Sorted triggers in ascending order
> > 
> >  .../devicetree/bindings/leds/common.yaml      | 37 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> Applied, thanks

Change of plan.  This doesn't apply cleanly.

Could you please rebase and resubmit please?

-- 
Lee Jones [李琼斯]
