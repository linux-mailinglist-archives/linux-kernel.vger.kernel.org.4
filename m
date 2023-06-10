Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6672AD0D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjFJQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFJQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB473C35;
        Sat, 10 Jun 2023 09:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AA261589;
        Sat, 10 Jun 2023 16:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74633C433B0;
        Sat, 10 Jun 2023 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686413537;
        bh=4mTrXdsYhf7nyFQ3z8yqygjtfuJD0iIWFZWiQEbc7UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwkMm9ovQ/+6/kPjFcx3NPsBl9PTGtracFGk3tVhBqLzEvPZob/VOC3T93g7QJXCM
         ARp8n8MGPJ6/12Vr9RurQtZoF+/9J/O+5zBu2ITlt4XU/Vm9tb9JJq/3dpEQRKUKE1
         MIELvj38ok+e0w0j+4b+y4CgMETmDUJE8GCc1wl8A5v3G0r8EqJk2EgFiiVKHf4A0s
         Yu0vvsILq5anE4DoLEVudpvZsK1WeDoVVXcwbYmAxHE9UQHsowtm9Iayh9cWQHF1xm
         1Kss0Rtkg7rOCi/eni6CtNpY/jOxcktd9FnC1dV7OAg3qOIN2LMIz1hVZnNINa9+wM
         uk4QdCwWHE+9w==
Date:   Sat, 10 Jun 2023 18:12:13 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Walter Harms <wharms@bfs.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tty: serial: samsung_tty: Use abs() to simplify
 some code
Message-ID: <20230610161213.4zk2uodjb7j2x7st@intel.intel>
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
 <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Jun 10, 2023 at 05:59:27PM +0200, Christophe JAILLET wrote:
> Use abs() instead of hand-writing it.
> 
> Suggested-by: Walter Harms <wharms@bfs.de>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
