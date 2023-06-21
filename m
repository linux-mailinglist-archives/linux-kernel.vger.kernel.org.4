Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71686738A79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjFUQHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjFUQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD2F1;
        Wed, 21 Jun 2023 09:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0D1615CC;
        Wed, 21 Jun 2023 16:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE429C433C0;
        Wed, 21 Jun 2023 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687363664;
        bh=ERzS/9EtJluGhGcJa2DP3Mj+yfrWqRBwMQOcEA4WFUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAjJ0QPQmEIelxZLY/kjfpvurBaki40RDTOlGXPAAJ41lrAtWvd4W1SJmeDEGCwpq
         o6wVIdhPpColJ8JAwdHCU1nu+6g3SwpL0GLYOELohtxmEp2qKdai+K3I6x+kVu93/N
         beXj4GUdYZ62gZ2K4gl/TOtHXscoYEalrIOoQonY=
Date:   Wed, 21 Jun 2023 18:07:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: misc: onboard-hub: add support for Cypress
 HX3 USB 3.0 family
Message-ID: <2023062105-chief-obstacle-ce0e@gregkh>
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
 <20230620-hx3-v3-2-2acbc03ca949@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v3-2-2acbc03ca949@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:58:31PM +0200, Benjamin Bara wrote:
> +static const struct onboard_hub_pdata cypress_hx3_data = {
> +	.reset_us = 10000,
> +	.num_supplies = 2,

So 0 is 1, but 2 is 2?

Still confused :(

