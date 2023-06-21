Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A35737A73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFUEuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44E129;
        Tue, 20 Jun 2023 21:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFA861464;
        Wed, 21 Jun 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B5DC433C0;
        Wed, 21 Jun 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687323020;
        bh=C0q8tSBU9YHYA35smiM+eNV9Weei0KvA3wfJzey59sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQgsDSRHz+7ns1FmJTpFcZtGICe39P1cpm4+hF5pg3ES1sRJGiI05+QTRI9kg09j3
         OFuc2wqTtCS79n9wVWK495E9OICbTrdRpLwb9AQfRSsWnRE21Zv35UmmzbjeGj2hk6
         gbqQI884yCj6OlH8T1XTLLXapTBWAoRHR1gY8wGTTEAImiiNo9QmXeLWNfbvoNdomn
         NmWY+B7oRxHZmjkwThq7QuewyRizfN7gMemUaT6xtLefukvmg83rZIKNP2y9ZfAkZp
         RnPjEEtp0KRjesw0IEVNiBdYWlpT9a09dsVvr+rMEu9rn1V8F9SQfK/US5NCMc5oKD
         dLTYt2gqmX3PQ==
Date:   Tue, 20 Jun 2023 21:50:18 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] thermal: stats: add error accounting to thermal zone
Message-ID: <ZJKBimjo2ny8/7bb@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <20230519032719.2581689-8-evalenti@kernel.org>
 <CAJZ5v0ho-wpwuuObNOxjcicPycAdts7KCzA-Yj+zj4X2dCpJsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ho-wpwuuObNOxjcicPycAdts7KCzA-Yj+zj4X2dCpJsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:32:45PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > From: Eduardo Valentin <eduval@amazon.com>
> >
> > This patch adds an extra stat to report how many
> > temperature update failures were detected.
> > Error count is increase whenever the thermal
> > driver returns an actual error or when the temperature
> > is non positive.
> 
> Why can't the temperature be negative?

I sent a wrong version here. My bad. I also need
to cover for proper negative temperature. Will send an update
on V2.

-- 
All the best,
Eduardo Valentin
