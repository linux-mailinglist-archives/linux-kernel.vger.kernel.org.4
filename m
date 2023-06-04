Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8A721733
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjFDNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFDNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D09CA;
        Sun,  4 Jun 2023 06:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A00E60ECC;
        Sun,  4 Jun 2023 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29441C433EF;
        Sun,  4 Jun 2023 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685884061;
        bh=ug6yIk3gLnuOUNDAW1HD1q9cHLzP72pUwoYylDgEJOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YchN8mCZd96V6tc2EqhDSrl2t591LeJpU+8B/PWcFtVhLbOIUMKxM19+yJl4FDdpC
         s1WCVQO9lJwCGfTm1aYPDlYSMFtO8P7/C06Des3xENE9Wnc4tX38b9i8bHjwqSNx67
         kykC0TPIRpr4zA0hwX+dLtkn/MaQI3nFlS4Ez2qHIDlf8mQm2f53ug6E2z9l1nLV6D
         TrEG29Fcz0+L2aU7l9E+VbRccBJQd5Mg7JrJxw114rAjVP8fKFpp1xKagXJxs54pr6
         tzXkkAvpl9egTKib7+NnCr/n8xc/6GUGSGzCu+rKulF65HJ6FCJrFA/UmGWWyIqxa3
         KDgN2H/xCBq2g==
Date:   Sun, 4 Jun 2023 14:07:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <20230604140737.18014e0a@jic23-huawei>
In-Reply-To: <ZHPRD0CT6K1IYgV4@surfacebook>
References: <ZGNpZM137jF5yzie@arbad>
        <20230520172405.0e1a3ff8@jic23-huawei>
        <ZHPRD0CT6K1IYgV4@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 01:09:19 +0300
andy.shevchenko@gmail.com wrote:

> Sat, May 20, 2023 at 05:24:05PM +0100, Jonathan Cameron kirjoitti:
> > On Tue, 16 May 2023 13:30:44 +0200
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >   
> > > Support Honeywell mprls0025pa pressure sensor.  
> > Series applied to the togreg branch of iio.git and initially pushed out
> > as testing for 0-day to see if it can find anything we missed.  
> 
> Hmm... Should the comments I'm about to leave be addressed as followups?
> 

Yes please.  As with previous, whilst good comments, nothing significant
enough that I'd want to rebase the tree.
Perhaps filter out the least important ones (one line vs two line on 81 char
lines) though.

Jonathan
