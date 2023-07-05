Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB15748456
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4EE41;
        Wed,  5 Jul 2023 05:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD5B610D5;
        Wed,  5 Jul 2023 12:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D2EC433C8;
        Wed,  5 Jul 2023 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560935;
        bh=IJTB5VarroPyc5MEwmfEMC62LALIPxpZaWc7l9R9e3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmlFT4THioSGvTOR2VL6bS+l+XSGOUKeYA//Z+PPjDoL5lPvB2R2vNLyTX5BFtoar
         3elMhitgORG3lBSt+T5bOOOIpsfheyfBA2OscyWjqnZZXEWP2wws5LBCqb9Vy08wLC
         1TivW3hPTPbYTihCyKeZiuWwgrAPuYQ30XApOYBYJMXoVendxIZl/ovYCAKqQBN6Hi
         HF75n4YPvVxmdYTSnSuekhO4WVz8QDJ1SaWi0e6Vg8PQX48y/z7C/tGL6y2t08aN8W
         i3cuzlAzGYd1OIwmONjc8kyMsTi3Dj4zEItWJs04CB6IrjoPMWeZBgBWKQOgnj1Qo8
         f+hvP8KaVFGVw==
Date:   Wed, 5 Jul 2023 14:42:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter
Message-ID: <ZKVlJLOCwn_vwkMH@localhost.localdomain>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-6-frederic@kernel.org>
 <CY8PR11MB71346F0DFCA82A7501DA0A4E8955A@CY8PR11MB7134.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB71346F0DFCA82A7501DA0A4E8955A@CY8PR11MB7134.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 13, 2023 at 06:57:25AM +0000, Zhuo, Qiuxu a écrit :
> > From: Frederic Weisbecker <frederic@kernel.org>
> > Sent: Wednesday, May 31, 2023 6:18 PM
> > ...
> > Subject: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter
> 
> I didn't find the 'lazy_enabled' variable in the patch series.
> Did you say rcutree. qhimark_lazy?

Indeed :-)

Thanks.
