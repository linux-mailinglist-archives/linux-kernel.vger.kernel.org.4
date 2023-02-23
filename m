Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677DE6A0B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjBWNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjBWNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:49:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644A7EC0;
        Thu, 23 Feb 2023 05:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D359BB81A31;
        Thu, 23 Feb 2023 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A5C433D2;
        Thu, 23 Feb 2023 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677160139;
        bh=+4NgEZ8mAdoQDhPz3j1fX24tUR15mbCKEWNXYntsbOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjfehBPqzasSQzWXD1898Y99whAAV7G+63b1liHDeL1qWllf73hsRgTv0PSikAClC
         gMaCnpriyleLxnBlFY/sRJq/1axUuNGxjhr5hwoZjYZehpLs+rsAaa5MSe2bW4gjQP
         HUDoSkDSi8XZ9Y5dW3VdJOo8osILapiFfDdrsaB20KblnPJgsxcZ2i2ptlsxmFv+8E
         Y5BcNDzbt+a7w2L/eRR93LNPynctIrzOkW9MzNpRoveZVcXomFaIafcQe6P8n6XQsa
         37gwxvPtXQ1OOHZ4aCvaEVtlYotbnXjhGJD/eCqx1R3zCyK7PztbEYWqbiSP0XrtRq
         vG2W2A6eFDYlA==
Date:   Thu, 23 Feb 2023 13:48:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Message-ID: <Y/duxo1aKFibuZtF@google.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-19-nick.alcock@oracle.com>
 <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023, DLG Adam Ward wrote:

> On 22/02/2023 12:15, Nick Alcock wrote:
> >Since commit 8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations are used to identify modules. As a consequence, uses of the macro in non-modules will cause modprobe to misidentify their containing object file as a module when it is not (false positives), and modprobe might succeed rather than failing with a suitable error message.
> >
> >So remove it in the files in this commit, none of which can be built as modules.
> 
> Makes sense - but if you need to do a V2, would you mind removing the erroneous claim on DA9055 at the same time?

Could you do this anyway please.  While you're at it, please remove the
'kbuild' reference from the subject line, thanks.

> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/Kconfig#L364 
> Strangely, seems it was always there, yet always bool...
> 
> Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
 
 Thanks Adam.

-- 
Lee Jones [李琼斯]
