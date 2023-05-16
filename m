Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092470504D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEPOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEPOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C11FEB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E95B63A8C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A72BC433EF;
        Tue, 16 May 2023 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246497;
        bh=C4y3Uk00b4aU06jByCl6x8jpmggK9uaNRQ9qhjOYusA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZ4VdeCZiTi1UkJ/y5mpr8S34tw2AP2QQHWL6MhdQfZrs9heq3yP3Y1DHT2JJKwVv
         baow6huRx0Cjpb+eff4v6y0EjMkHpLc+c9R3ltc1F6LPhQIt7IK7Jed7dt7dfFClNm
         i3CIu4l9s5g6DlxtcMLvUiODsVB6LzwzSK5aeAveEReZbcRpwyI8Slg4zD7jbkZFcP
         GYpKqxj3X79iBJKKVyQacUSNRCWFZu72E+Re8W60xYlZi4RfaFtgmTIWhgVKvGyCbT
         OfmurZbnkZSK7nOnpuXqTyLySO6d1gcAEPvCyYFS7xP3wxEAeT8ybW4Cz6ZL8mrS30
         xVeVq48DM5yQg==
Date:   Tue, 16 May 2023 19:44:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] phy: hisilicon: Add inno-usb2-phy driver for
 Hi3798MV100
Message-ID: <ZGOP3bvi03//+6IU@matsya>
References: <20230509060449.1151113-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509060449.1151113-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-23, 14:04, David Yang wrote:
> This series adds support for inno-usb2-phy on Hi3798MV100.

Applied, thanks

-- 
~Vinod
