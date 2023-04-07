Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937256DB1FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDGRqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDGRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D22B468;
        Fri,  7 Apr 2023 10:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3988640E6;
        Fri,  7 Apr 2023 17:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A3CC433D2;
        Fri,  7 Apr 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889565;
        bh=KdK0eVnuC80p42y/A+nIcCrO0YdAb30rb+T1OZFDDbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n3GPu2KVJUymwpTk49GnUnMsxD8Ynaxmvn7NDktG5RS0cQcfi3nZ1pP6YJAf4DkhU
         nJ3EuJfgvu2+6dlaWL7/jjoOE6XjvW6T95CthzjJqbCRw6FB28UTulZ07Cl7m5OY6Y
         VJeQqn+xeTO7geE0hHV5onHvHexmbQ7IBC/NDEOMaQipRFCXpCZlKSL1Wp8JSyqe4p
         taSbI8Lu6mm2hJE/8LzZFxSgtM8R60xg2RMy0c8hiddw9Edp37r1VT3tdSwYyp42q1
         +MDbx8wE4bgqsTxxHW1zTy38vJ9FL2Qncp3QFrprN1A7kr30aiJNSMkZWuZ89CDG7J
         FtB5but9LbwBg==
Date:   Fri, 7 Apr 2023 19:01:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, lars@metafoo.de,
        angelo.dureghello@timesys.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: set varaiable max5522_channels
 storage-class-specifier to static
Message-ID: <20230407190121.7dfb598c@jic23-huawei>
In-Reply-To: <ee03cecef9139720a9818aa434dd34ae433d8e9d.camel@gmail.com>
References: <20230404013828.1914523-1-trix@redhat.com>
        <ee03cecef9139720a9818aa434dd34ae433d8e9d.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 08:43:32 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-04-03 at 21:38 -0400, Tom Rix wrote:
> > smatch reports
> > drivers/iio/dac/max5522.c:55:28: warning: symbol
> > =C2=A0 'max5522_channels' was not declared. Should it be static?
> >=20
> > This variable is only used in one file so it should be static.
> >=20
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
>=20

Applied to the togreg branch of iio.git (pushed out initially as testing)
with tweak in patch title to fix "variable"

Thanks,

Jonathan
