Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08331600A80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJQJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJQJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:24:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD657E12;
        Mon, 17 Oct 2022 02:24:08 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e793329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e793:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 710EE1EC067E;
        Mon, 17 Oct 2022 11:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665998642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DbOhjsH9FiMyUQro/PbvTQBbEjO1qEWwbnMtw3Dds9A=;
        b=NPNJgq2hMXUuiRb6m9Z8rBDurEljnui8VsqGTVwEDvfYIVGcTnExdfOS1X8sGMiYXCdpLV
        SikhGfUXxrPaoRXJAmExtiVdK5hlJO+3StTzldyVn9WiF0KkhZYDlQXAVYfh7lgeqQJZln
        aaSgfSeMB7NJrdTByS5bfHIBZvIoaIY=
Date:   Mon, 17 Oct 2022 11:23:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/misc] Documentation/x86/boot: Peserve
 type_of_loader=13 for barebox
Message-ID: <Y00fLpOod/rDHUb9@zn.tnic>
References: <20221002125752.3400831-1-a.fatoum@pengutronix.de>
 <166599647272.401.15990841004146726447.tip-bot2@tip-bot2>
 <1a69fba3-6a10-e78a-f1ee-70eefbd59a62@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a69fba3-6a10-e78a-f1ee-70eefbd59a62@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:51:28AM +0200, Ahmad Fatoum wrote:
> Thanks for applying. In case the branch is not non-rebaseable:
> 
> s/Peserve/Reserve/ in the commit message title.

Whoops, fixed and force-pushed.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
