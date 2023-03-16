Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10716BC3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCPCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPCs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:48:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B928D2F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:48:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c18so275262ple.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678934906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTKufV9UN/6aHOHpRQh2aerDUcw2Pd17xq7GQusDlwg=;
        b=WleEFJRlmZwN8NDHM4mj7yb1/Ij3Pwi33cyDB1b2+YWgPiv+r9oZfo6qkg8KgND060
         j4UlhrASW7PrmGfDhCl747ym23Fa2oHCo72hAz1EMtP94TtPJyCrS4xJ/RGerk3SYDTG
         AhILJ1UsCruQOxz8Y0gQ/okuLf2jZVYdQrbOIbyiTwnO9sQbg/QQ8D6j9qpyeXML/GpC
         FhTwI6WI2VqXVM/dEXR4EMeOuFhE9p60zclGawN/+BmU29HAalk+1XsE21lNOkyQN82V
         aMzvZs4xFhVoG45S5iNeDDSujUQGq3/Bg7t/ZVj5tLKiynEpwSG5fuzIp664zxVuGbBe
         RNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678934906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTKufV9UN/6aHOHpRQh2aerDUcw2Pd17xq7GQusDlwg=;
        b=5Cp2mehrT22FkITi6f/bQIlF+sv8E09VGisuaiqx8xgHEWcmt3g7laK2RDmVXz1M4J
         ZeKCqZk+zS0//Kcdv67Dt+yF6ey7WlfEVEJ3hrW5OSCivenBqqdgimO0ZIKTNyO1Nwdg
         KjiPbEHbSH2VY7cx5akTgvN0fZmThLuPXhQcgFcuzduT7CjZN3Qf5sY3afXg0bitw1sL
         y3N5eLkQCULCfwg7gv3S4sLJlsiQPSZXWuL4fWV1xzY0DqDu3Gp2CBNd4XYTjug10JiP
         YORWF185N2KiaADKpedM8wSHyDSECcIzp7rPUneVile3jKX0S+1nAjZV6CUCSaiOalee
         tsmQ==
X-Gm-Message-State: AO0yUKWi619W0FCDZTA+CWqUdwzcRPs8nfqGhitjl/FKmhWqclaLa31T
        Ci6dR4LjnpL1Csow8rOBVfM=
X-Google-Smtp-Source: AK7set/9k02ydkxJEv0mQ0EZNKzmeLns5+SDZPxIlZp8Yi6wL7O6KZvrkz6mPVOclFCGo7jAJhYfrA==
X-Received: by 2002:a17:902:cec4:b0:19c:d97f:5d16 with SMTP id d4-20020a170902cec400b0019cd97f5d16mr2081524plg.3.1678934905930;
        Wed, 15 Mar 2023 19:48:25 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-41.three.co.id. [116.206.12.41])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709028bc500b001a19196af48sm173475plo.64.2023.03.15.19.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 19:48:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0697E106570; Thu, 16 Mar 2023 09:48:21 +0700 (WIB)
Date:   Thu, 16 Mar 2023 09:48:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBKDddHeKlWohA0T@debian.me>
References: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SBJ6ZCI05vY7XdIK"
Content-Disposition: inline
In-Reply-To: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SBJ6ZCI05vY7XdIK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 11:35:37PM +0800, Kloudifold wrote:
> Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to sn=
ake case

If I only see the subject above, which functions are renamed? I have
to see the actual diff if the patch description doesn't answer that.
In this case, I think the proper subject would be `[PATCH v3] staging:
sm750: Rename sm750_hw_cursor_* functions to snake_case`.

> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@i=
ntel.com/

kernel test robot (lkp) reported errors on your submitted patch, not
on commits already in the tree, so both Reported-by: and Link: trailers
above are not appropriate.

If you want to add trailers from someone else (like kernel test robot
above), you just need to write e.g. (ignore markdown):

```
Link: <link>
Reported-by: <identity>
Tested-by: <identity>
```

In other words, trim the preceding ``| ``.

See you in v3!

--=20
An old man doll... just what I always wanted! - Clara

--SBJ6ZCI05vY7XdIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBKDcQAKCRD2uYlJVVFO
ozthAQCwSUBKCNNTZrAqYE+Oq+ztciMHrkpgxQtV6sr9YJ6BZAEA/PO2kSXaxC/f
Vvy6BMrawJz3yTvguvVWokgh5RWxHQQ=
=j4A0
-----END PGP SIGNATURE-----

--SBJ6ZCI05vY7XdIK--
