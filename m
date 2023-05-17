Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618CF70604D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEQGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEQGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:40:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14682CE;
        Tue, 16 May 2023 23:40:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E2398108;
        Wed, 17 May 2023 06:40:32 +0000 (UTC)
Date:   Wed, 17 May 2023 09:40:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: omap: Partially convert omap.txt to
 yaml
Message-ID: <20230517064031.GP14287@atomide.com>
References: <20230515074512.66226-1-andreas@kemnade.info>
 <20230515074512.66226-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515074512.66226-2-andreas@kemnade.info>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230515 07:45]:
> From: Andrew Davis <afd@ti.com>
> 
> Convert omap.txt to yaml.

Looks good to me, thanks a lot for doing this:

Reviewed-by: Tony Lindgren <tony@atomide.com>

Anreas, for future patch reference, care to summarize what's still
blocking updating the rest of the TI SoCs for the binding? I think
it may have been discussed earlier here and there already so apologies
if I'm the only one who lost track :)

Regards,

Tony
