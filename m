Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB13A6F68E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjEDKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEDKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:12:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E949EC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:12:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so249645a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683195132; x=1685787132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63RsklUDkur4gKMHnok46OOJgYylgOu+yKrP1uDEnlY=;
        b=D/sPsVCUDnBaq0ihqBH1FG+TlntaFA8Ez28piE/BPW5w5PEaj6rIyOiYIicBPorD7c
         ciJT0ifZemRiwOJrRz6Cr1/5W0iDabDyLf/P4W8ttDhcwZ4NKbk4sGJdevpUYR4cI3rl
         xCeoZ5d5c0xnQYQJESIAwjIdQ3elXL4yShhmoR+6YIGuyxAI+uMWmAJ6T2SPvVqKubv3
         quWuaj2Q8J2w+IZjUc1t61P3zCntEBQLGsIZMe5LSGVhJPB9845Wf8nzckRq9ug3g4y/
         QECtZpZuqT46ONGDOtKszLep25iQkHaQ9oV+7HhP/Z2AqPGpZWG8zFe6cRkhV4/FPEvh
         gklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683195132; x=1685787132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63RsklUDkur4gKMHnok46OOJgYylgOu+yKrP1uDEnlY=;
        b=FdIbsEVfZemlkY+OC0ZTKRCbBiAW3BEPSz/9h+tiNOyPN010p53Y6nMiZxRsKABN/Y
         xQO+tDWx+gQgtLHVDYD0LyCGxRmQQkua0P69s0i4fcY8qMqJ2PuZS74yCejr9xNkoV8z
         Yq+8QLuxsy16y/JHvlwiTyA2q28Cp9vjWpCl/wd7BRgDWG8OduiUb8R0zUDt7enUUc3b
         4DHaZZsNXBTvyD/+9w8SvsGnXcbYr1LAo+NKtuCsd6vEOXXbd8rIg3pfbuGBMjrwKanB
         uIDYizm+8MaxyMwH36vyQTGOzHlh7oyI7SKa+BP7OZNuk7V+Ia7hyCZnzLJAkPNgpiBr
         sE1w==
X-Gm-Message-State: AC+VfDxhhxVYhI8CXVXZLWqlr5ubV9hH1HwAwtpiHngRsW1ELYskibf+
        oJo9AwBUkkQ0Q11l7AHTfe4=
X-Google-Smtp-Source: ACHHUZ5QNU8/hK4GG5Wyb9wTLMVrL4vkBC6kS1OGXo5VtSEwJ81QDrrxgaYHKCGZFdtOzTKGjn7VHQ==
X-Received: by 2002:a17:90b:3b52:b0:247:140b:c5d6 with SMTP id ot18-20020a17090b3b5200b00247140bc5d6mr1465642pjb.45.1683195131679;
        Thu, 04 May 2023 03:12:11 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090ac20e00b0024ffa911e2asm968119pjt.51.2023.05.04.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:12:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6CEC210625E; Thu,  4 May 2023 17:12:08 +0700 (WIB)
Date:   Thu, 4 May 2023 17:12:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bo Liu <liubo03@inspur.com>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix double word in comments
Message-ID: <ZFOE+KILDglRL3UJ@debian.me>
References: <20230504085446.2574-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CU1CFwkKJgVRqNfs"
Content-Disposition: inline
In-Reply-To: <20230504085446.2574-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CU1CFwkKJgVRqNfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 04:54:46AM -0400, Bo Liu wrote:
> Remove the repeated word "the" in comments.
                                    "... in highmap_start_pfn() comment".

>   * This is so that we can have both a directmap of all physical memory *=
and*
> - * take full advantage of the the limited (s32) immediate addressing ran=
ge (2G)
> + * take full advantage of the limited (s32) immediate addressing range (=
2G)

The diff LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--CU1CFwkKJgVRqNfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFOE+AAKCRD2uYlJVVFO
o2EyAP0WqKBdA4MCy1CPvnb0wlzDpbiZs0KK3VgtimYlbGakRwD/Yv3tDWqzNj5k
eQJQaNK+ai6KoBw0QT6GTXJhqlIGLwo=
=QDit
-----END PGP SIGNATURE-----

--CU1CFwkKJgVRqNfs--
