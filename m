Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B568E6FE0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjEJOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEJOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:43:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA58E51;
        Wed, 10 May 2023 07:43:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so69531953a12.1;
        Wed, 10 May 2023 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729800; x=1686321800;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hV3wpq0G9wCRSZdx/DdZ2PROV9kmk2slGRLRteDA5w=;
        b=G9bVTcj1pWNQLAWnaqugWkF4YORPIxKseaQjcYAaMSeX2/MqYY7rcfz22FOVpCQ1+n
         Kk0fqjYbnX66zfk1t0TyNz0PMw/YjOTOinHBOz+HegLnL40wLQ+khhbCvtjBWgt0LkKa
         q76bLgHdvVUap/aHGPPtxeFqILlsQ/doTeBdAu9QCWoMeSRfh6WL07HVwyAlmS1B/skA
         EkYHTFm+Ygcd0RMXSyIKfY3Xf+1jnz67tl8dzouNDzh8u9P2RFCTE40ZhH236guScxxc
         fm21XmneVv3P8tdp/dbjp5MM9Fe1SVUgW7Ca51NQzKEFvHIFlt3TX8qbLlDqd2hz+PFy
         tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729800; x=1686321800;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hV3wpq0G9wCRSZdx/DdZ2PROV9kmk2slGRLRteDA5w=;
        b=KGd3vWm4g2+AbIQlyNc2TZMzLQxoHqCk4tDnaKRkBnx0Ejz3AU4d/ky5Fc1L26du44
         ClGbFq/h1xvQ0+Q5ffbDpS/2yXRfzHqGKZt3RlHDeVk3EHzVV5oGzm9mCahoAgAAXfQt
         J+un7mTZ+BTM29RNcL9M9MteN50jRm7pG89cLKNEwZ7hS9sV748i0ZrhU81rer04jWD3
         5rsXDGs7uo1aO++TZzj2t9f5ECTfS/MEy9SI3Uq3DV/rRyGPz/IsnhJPZ/MUaV6wdX7L
         GamaZX44B0UrS9oQJxkpH3PEoN1azemaz6EYhjw7cPwfba3VDm+vH04OzQvQ0E8zMav6
         GbZQ==
X-Gm-Message-State: AC+VfDwhD+QIaTulERxrM0XCi9dFEryOfBhC3u18pOmENgHnRGqbB86o
        iX6Gf0A5UH14YPDOGatu/3U=
X-Google-Smtp-Source: ACHHUZ6m7CK42mQO2T8kd4XGundaYWXII/u55zQo3uh+SzdrNIrTpeuWBv7+02zKXP687ms302r9xQ==
X-Received: by 2002:a17:907:25c3:b0:966:399e:a5a5 with SMTP id ae3-20020a17090725c300b00966399ea5a5mr9695095ejc.35.1683729800169;
        Wed, 10 May 2023 07:43:20 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p3-20020a170906140300b0095850aef138sm2712576ejc.6.2023.05.10.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:43:19 -0700 (PDT)
Date:   Wed, 10 May 2023 16:43:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     stefank@nvidia.com, jonathanh@nvidia.com, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/6] firmware: tegra: Add MRQ support for Tegra264.
Message-ID: <ZFuthhVUN9x5Ul5H@orome>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IEJ6DYV1KbmUKb89"
Content-Disposition: inline
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IEJ6DYV1KbmUKb89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 10, 2023 at 05:22:42PM +0300, Peter De Schrijver wrote:
> In Tegra264 the carveouts (GSCs) used to communicate between BPMP and
> CPU-NS may reside in DRAM. The location will be signalled using reserved
> memory node in DT. Additionally some minor updates to the HSP driver are
> done to support the new chip.

I was still reviewing v2 when you sent this out. Obviously none of those
comments have now been addressed, so we'll need v4. Generally, try to
give people a bit more time to review patches before sending new
versions even if you've got early feedback from the various bots. You
can of course already integrate fixes for issues pointed out, but there
is no need to rush one version after the other at this point in the
review cycle.

Thierry

--IEJ6DYV1KbmUKb89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRbrYYACgkQ3SOs138+
s6EFCw/6A5N4Xb9K0Gos9YvwfXHEOAd8hMmqMuped7QrmRL8CQVriQCPmLz4kNql
cKJKQ3jgszXISSHLtXY84GA6Nf+WUTxzP+H8cqoTsVeMyEuXjz8RD5MSn/SdwRGO
s3LMjoAfTfSlsVRKLU+7uLxGslX08kiibnSrXJP+xrM6g9v0rfDT4KSsXENahjge
EhI8L1r0k7HOcvpVPCHG0cWeQDQcvEgMTuonHQy6YnZR0XRuozZiOE3CG6vjtCY4
beT/pvjTVG384JziwtHqVTDI/YijDdml6KpvivouTjPcshoUYc7lDapt/hMWFkb1
wjsMVJ7YTyRtHM+51Au+OQZzWhDCv709FI4ix+L2Fb0bRVZNAQ/pwPoQyL/yNain
0wHU32ag9gnIFZxCh+ClEe+PGq428FlpgI+BBZkhCWGs8fn7dmpgU0HdOtwSnUAC
N/M5STkfcrx7nc04658sEt7IY+fBbdCP6URQ2/oeXhewYPIOax3704ns2p1jnDD3
XVZK7qQuQtFNr00qOSjPDnGzQVBFo8XmfrmxenYWEtsQbZM7WD6yYg3Dth/2dyol
UoHWvmgFJsvzBbOoPMHDozHyb8DV7n1rQ5suYWAqk9evmhDZ1CdCfnAV+KNJuREx
Yu8k4hJOcrPnAmEVcYjdjjk0+Lsxz+whWmMH7fUWmp6w9/u5zzU=
=5MKS
-----END PGP SIGNATURE-----

--IEJ6DYV1KbmUKb89--
