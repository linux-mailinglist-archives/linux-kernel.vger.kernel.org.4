Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF66EEB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjDZAfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjDZAfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:35:47 -0400
X-Greylist: delayed 50100 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 17:35:46 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D4BB;
        Tue, 25 Apr 2023 17:35:45 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 97E92C01D; Wed, 26 Apr 2023 02:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682469344; bh=WkAOxd1G4B7WbFDuFK2jnLsO97agfT/cj1gWYlIL73s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZe68lAlyVt/HxiPSMN5GL0FDy6zoCEybHQtU6iqUo9/hXQJcYBY/VBz129sC0YfY
         +DLMPoNQRxR/SUjiW6quXyPGN/zE1LPBrtFpomRyvokxCODmyNyHxF0UMF+4H3lCzV
         F/LU6RCVi9K5TxLgH1j3h0KaryRrew+22D/W9Gxf4wteizilrS74EBniHU+rDW9fQb
         3RFe/dMwz3vTsNJNK2NbZ167Qf+lzIiNuIjsIt+ODytYuAlmSdE/9a2BmqwfFZsn5O
         LUcnxkJLRcnJ/KJ31VSx/clx9QqnIjM8qPIXDNTlQMIHJXZWFw1H6Ab4uv6g7po+A7
         ee0ymPbYmDLww==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 77F15C009;
        Wed, 26 Apr 2023 02:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682469343; bh=WkAOxd1G4B7WbFDuFK2jnLsO97agfT/cj1gWYlIL73s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mF/VMeuCx6NWy3dSCaV6givEULXRt8VNNvme65N08336Ai4m5pz2D+6DxOMy4VyJH
         0F1xBHRmSk1rsge9RJ+Qo6ABiol5LtD42GTcfKKtPYic+feaEzWOK3+GZOtmfonf4n
         BySOYF1NvS05EdhvFZrnwmoVElYMWdI0O1Xf2Ql2FcBGbCWQ3hoqXtmhq/2bKjohf6
         SPyAKlbg+6aZA+HCfgU0WkxIVP0fCisuusfpH31GeTARl2KZPNX5wf6Ks+7GXvLW5n
         XhMe7s3u9ccMiFgfcOZumBZzMczNniufG/e3RoHZHeJI/NUGRxKIr6OSTZfaYKjMwG
         XP1egKzDRErUQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 2208154f;
        Wed, 26 Apr 2023 00:35:37 +0000 (UTC)
Date:   Wed, 26 Apr 2023 09:35:22 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        v9fs@lists.linux.dev
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Message-ID: <ZEhxygpFsFstKlrX@codewreck.org>
References: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <ZEd8d7W6HnHE_66m@codewreck.org>
 <CA+_b7DK1s87y-_-D3sQxteqJ+78uvKza-vgWGv9SmGm-tqz7DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+_b7DK1s87y-_-D3sQxteqJ+78uvKza-vgWGv9SmGm-tqz7DA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter wrote on Tue, Apr 25, 2023 at 02:14:52PM +0100:
> The hash is constant unless Eric does a rebase.  When a maintainer rebases
> then updating the fixes tags is just part of the process.  Often they end up
> folding the fix into the original patch at that point so the Fixes tag is not
> required.  If a maintainer doesn't update the tags then the linux-next
> maintainers will notice and complain.

Good to know this is checked as part of the linux-next tree checks.

> #GitMagic

This isn't magic, this is painful to update manually and easy to forget,
which is why as a maintainer I'd appreciate having a heads up here and
why I mentioned it.
(I'm sure Eric would have noticed anyway given this is fixing one of the
patchs he really wants to get in this merge window... But, well, in
general)


Re: folding into the original patch or not is also tricky as it weakens
recognition to the contributor, so I tend to keep such fixes separate
unless the tree becomes completely unusable (e.g. doesn't build) for
bisectability.

(I really, really wish there was a more mainlined maintainer process
though, so each maintainer wouldn't have to come up with their own rules
and tricks for everything... But I think that's a lost battle at this
point)

-- 
Dominique Martinet | Asmadeus
