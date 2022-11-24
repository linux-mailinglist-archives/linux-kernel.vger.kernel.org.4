Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA756376BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiKXKpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKXKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:45:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24015BB04;
        Thu, 24 Nov 2022 02:45:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHvm96p8Qz4x1T;
        Thu, 24 Nov 2022 21:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669286746;
        bh=a/rgvu+x3DNbb+TuaqIRMakhyJTfbEd0k5XDjibLn0c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hkVtP7+TE9HiKfugwKMBr7W3jSEBpBQYR+0GKGVSazAx5OXNysgYeiUzQZR/ioHTH
         dDR1vgi5ikZvLL4SHV4mGpLqv0Z0Sz8kbdb6rwrt763FeZt/I2xLpZapYdgOOA9A4p
         8ipjhhxE5DInT76L6F+bFLnBqkXvKttNNAXEbl12lAsGcKNxfPER4nQCYfaQXuicoT
         Bbg23ccChwoTDAXIuiR/p2D5LwK3X/o8byq42yLoK7zTPZi5OtaGousTMDgviiOVdu
         0j+0Xi8T0UgkNI+Eq6xGXdnaHtTfeSnO2G80owAYuLP7JvWi1vJHJgNoGYcfYGM4Li
         knciml4JyJuKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: fix typo in comment
In-Reply-To: <48936161-3e97-e8bb-1f85-ea511c13571e@csgroup.eu>
References: <20220521111145.81697-82-Julia.Lawall@inria.fr>
 <2835d67e-8ca0-cc2d-b86e-b2ac254428ab@linux.ibm.com>
 <48936161-3e97-e8bb-1f85-ea511c13571e@csgroup.eu>
Date:   Thu, 24 Nov 2022 21:45:45 +1100
Message-ID: <875yf4d412.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 23/05/2022 =C3=A0 01:27, Andrew Donnellan a =C3=A9crit=C2=A0:
>> On 21/5/22 21:11, Julia Lawall wrote:
>>> Spelling mistake (triple letters) in comment.
>>> Detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>>=20
>> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
>>=20
>>=20
>
> How should apply that change ?

I will.

cheers
