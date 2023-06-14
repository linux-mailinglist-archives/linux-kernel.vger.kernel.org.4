Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9B72FDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbjFNMFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjFNMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:05:33 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 05:05:32 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460801BFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686743964; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HkDbnRCmoXRWNIKLy1ufRJJHJ8S8GbSncnuei3xZ5vg9XOnDYJLevzzXaPvZvClNk/
    +CeJfyay1LPc78vCc7yvGwKnIZ+mcMTLwiVaiDKPoKZVD0udhaaf1q4H8RzgUeLEEOwk
    AS/upRFkKFSr/55+tY0YTHPCvgHmEP3vNoTAQBFz63xCHdYFB41JVcKx5AZJqagbAd7F
    JCGW/ocgyOu3X9K4v1SaW6kGmRn/RMUlXdgdjWWDg21yalsqKYzAIZ8StGncZLV+6tU2
    8xvmYO/DtTyh/pgcFA3ZyzVrYxgRTEwCMqV5EzkcDgFecRB5wX3qJHEuqgNP8tvMLxNd
    zQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686743964;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vMoc5VyH6n3kW4KHnsgIvyCuToj2ccHvrt1ZTeOdzfY=;
    b=KL94Es3IlnwhXkEbHGWsdDldB+UzENsYx3vZlZKJwdCTkHY86u/8u8Dp8JCzSKr8Go
    UWCZokMZWhRfRRFu4IPdcsGTDcPgkETvUbNzm9BKdfZqmvs2VFIuEfeO1XMGypGgFXAe
    SBW9oMne8QP0KyniV+3GA5Tx70FUq74drMyTGQMKK1l/PGuZUPPrSjW7egV/xXL/a7OL
    8FZZmscKmEW27457FD0jXeTgXyONZPotDWYqi2dk94UcNemFrroFXiSpd7WwNeS5uY+Z
    m9nVz/DLyrSW8cDGpiF+wLNw83WYsc8IgKlqowVjHb3aAXzWGPcERSBZfwO3t/RVzFXo
    5ZIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686743964;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vMoc5VyH6n3kW4KHnsgIvyCuToj2ccHvrt1ZTeOdzfY=;
    b=RKMZO3FaYpNAQ6A8OqoTKstrmE5MsvwauNT3avcPv1CsJS3jb8iaTrnznpDISj0R/P
    5nSaiHkUy5TiMmnsckF9RAtYFkcN0CxvXqabinJj9W7zbtmYXMmdOcexERGyokWt09E7
    MkcAv+cUcUGKzAO06q7k1yl4zslVIYNi2Q+vVy1ulEQFM4TcPyTLPOqG5mV+J5Q4kOpo
    2kXFNb84Dyye0KAEtgqe1d1AJIFn4ll0IWjEwcHtPkTAyFHk4UDjiHCqGb+OXHDCY1lu
    6O5/TeWuprTK2dazytJz2t0FI5SfsclGrE1e5/y0QkBVp6OcaxW9t15SaNAS6tbX6lMA
    oIGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686743964;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vMoc5VyH6n3kW4KHnsgIvyCuToj2ccHvrt1ZTeOdzfY=;
    b=yPJPMBEmSSaPLxIkjJNDt5qzpzC3ic8YZ4opGjYYUjlpxJwFg1PVfYv7A24JTpY6pW
    vLalZ2mckqYGmKikLiCA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9y2gdNk2TvDz0d0iwLwE="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.5.3 AUTH)
    with ESMTPSA id qe6984z5EBxN6WH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 13:59:23 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Mahmoud Adam <mngyadam@amazon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rsa - allow only odd e and restrict value in FIPS mode
Date:   Wed, 14 Jun 2023 13:59:23 +0200
Message-ID: <4502349.tsrQG4AIub@tauon.chronox.de>
In-Reply-To: <ZImNfECCS+22oF/D@gondor.apana.org.au>
References: <20230613161731.74081-1-mngyadam@amazon.com>
 <ZImNfECCS+22oF/D@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Juni 2023, 11:50:52 CEST schrieb Herbert Xu:

Hi Herbert,

> On Tue, Jun 13, 2023 at 04:17:31PM +0000, Mahmoud Adam wrote:
> > check if rsa public exponent is odd and check its value is between
> > 2^16 < e < 2^256.
> > 
> > FIPS 186-5 DSS (page 35)[1] specify that:
> > 
> > 1. The public exponent e shall be selected with the following constraints:
> >   (a) The public verification exponent e shall be selected prior to
> >   generating the primes, p and q, and the private signature exponent
> >   d.
> >   
> >   (b) The exponent e shall be an odd positive integer such that:
> >    2^16 < e < 2^256.
> > 
> > [1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf
> > 
> > Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


