Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD17393AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFVAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVATO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:19:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F50A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:19:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmgwD1y3Tz4x04;
        Thu, 22 Jun 2023 10:19:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1687393151;
        bh=e1vNIrKkUVeA1lDXf5ILJ6GZss64BKmuwgfbxbz1Xec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sOGo0b9An8yn8yuI5B2TyY9eRC31nTORHe4NUYIqg2H624n74q4jkenwrK+2m9rdS
         tZoID7tMMZ/2iZi6X6aZNeUIwJ5G8lFjDMJINW3WRlnkSTja/TloOAgntkmqYPbgUp
         K1n+WNG00qiHCzHTi8oQMAr3h2AI7r53v9qy2owqTuXn3Ik0CRdGq8Ez0YKtoOAvPc
         8FHSomDjqyv+YfvQAryM+8f1sbP0uUfk9M2nHYQWWTC1yQEWS+Vn+Bs0YNQHH87NZX
         n2YwtxFJiYUP1a5ZoPArvdUALxX3kUigFtOUwE3dOMk50Ili7tjse1Z2DFLWz2stei
         7sSmI8wubm9YQ==
Message-ID: <68f894d014dce50ffd2c46684593e18e4e8b4931.camel@ozlabs.org>
Subject: Re: [PATCH 02/79] spufs: switch to new ctime accessors
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 08:19:05 +0800
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144735.55953-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses
> of inode->i_ctime.

s/utilized/used/ :D

All looks good on the spufs change:

Acked-by: Jeremy Kerr <jk@ozlabs.org>

(also, thanks for including the accessors patch on the wider list, made
it much easier to review in context)

Cheers,


Jeremy
