Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73373BB22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjFWPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFWPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674692695;
        Fri, 23 Jun 2023 08:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDDB61A91;
        Fri, 23 Jun 2023 15:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FABC433C0;
        Fri, 23 Jun 2023 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687532949;
        bh=oVMjdRr+KfLG93yVPncjOTigDLQGeF07bcMpgvt79aU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VWoNz2HQ6VNICUY/GG463ZCpfiPpYx7NJSqmaKJmH/MyqdPy+Zhjrwzo8Wt+mQmSe
         0bgw4MB5ET72i9XaKfP8taHiffl8BuOqPzDAojfEC6HFuhvFdQFHwPpsCwHtdW4/5u
         Ay6b37OvmwLTm5Sd6RCh9YHwvUU7IJyeMtY+ULKzpQWJgs4C2nAFpbxfSnfsVMmQfE
         vTeBgNai104lESAk67jdlFYZOaFbpYgnHLoa8XAWNmZGDHpbRcNrnkUqbLuNwvEHJM
         U9qulT7bawXUxg4hZfH/M3TFxQl+OjwqDdrapzpiYVLPUq3A8M4D9ssdLWGTvNwWNv
         E7GHzkksQOlkg==
Date:   Fri, 23 Jun 2023 08:09:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230623080908.6961509d@kernel.org>
In-Reply-To: <CAJqdLrocJkzTFUeESTHwOAHpGcK7Tqx54XsdT-0g8Fm2=_xcnA@mail.gmail.com>
References: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
        <CAJqdLrrVfQx4fWJjpf0Nz7AdiNshdFi7xgXis_iO1jgU0YeGXw@mail.gmail.com>
        <20230623-baldigen-eisstadion-38bd00a856fb@brauner>
        <CAJqdLrocJkzTFUeESTHwOAHpGcK7Tqx54XsdT-0g8Fm2=_xcnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 14:28:06 +0200 Alexander Mikhalitsyn wrote:
> > Seems fine to me. =20
>=20
> Thanks, Christian!
>=20
> Let's wait for Jakub's comment then :) Then I'll prepare and send a patch.

 =F0=9F=91=8D=EF=B8=8F sounds good to me as well
