Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21767F072
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjA0VdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA0VdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:33:24 -0500
Received: from smtp-out-04.comm2000.it (smtp-out-04.comm2000.it [212.97.32.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2612A175
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:33:20 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-04.comm2000.it (Postfix) with ESMTPSA id 2FDD2BC7089;
        Fri, 27 Jan 2023 22:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1674855199;
        bh=kdoAqMrExVGaNoV54ZBc8DPfktno9RS2Tt30mZjgcoE=;
        h=Date:From:To:Subject;
        b=ztTJ8luJUVeI2F+/Vxj92d7hzdAEZsQNU7BTVbHlqhE7S7ve59G8Quv73XIEd0jOJ
         kl+NNjqdhXHKx2A3i4gTAwHBrEezGPmDnsWX+mspTRtePRtSqs8BS6huIKl5LGDzfb
         9PJiYMtkWyHCFrv+5jwL9m00eqBQkI8+UDlAmrBf4zGxcLXk1EJ63u1qbJv6hS1jUn
         Zg5JglkCbPZ8vQdoRpeJKnm9WSgCicfDTzVbKUCub3uQ5ID5dLTe/vUTG1NpLgD8yp
         OS+nHX1EFZO2CjbMFhHaTi77fbqgYzz5/bJ1dajKJxvHXrIRth3p+Ohm3hFW7f5BDG
         s66k7fSW8W5KQ==
Date:   Fri, 27 Jan 2023 22:33:14 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: fixed-regulator with enable from another regulator
Message-ID: <Y9RDGnZLg6wGJWwn@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am trying to figure out if it is possible with the current
regulator-fixed or with any other solution already implemented in Linux
to have a regulator enabled from another one.

I am not talking about the regulator vin-supply, I am really talking
about the enable input signal of a LDO connected to the output of another
regulator, a sort of "chained" regulator.

As an example something like this

<reg_1v8>[out] ---> [vin-supply]<reg_1v0>[out] --->
<reg_3v3>[out] ---> [enable]

<reg_1v8>[out] ---> [vin-supply]<reg_1v2>[out] --->
<reg_3v3>[out] ---> [enable]

<gpio1> ---> [enable]<reg_3v3>[out]--->

in which toggling <gpio1> control 3 different outputs.

I am still not 100% sure if describing this specific hardware connection
would be required on my system, maybe I can just ignore all of that.

Any thought?

Francesco

