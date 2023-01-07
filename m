Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354C5660C86
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 06:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjAGFRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 00:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAGFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 00:17:32 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB89084C;
        Fri,  6 Jan 2023 21:17:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 7so2510957pga.1;
        Fri, 06 Jan 2023 21:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtn+wuGPbmDyYYGZWDOeGaLOLx9crboCVQLuM2/+veM=;
        b=R0Gl+WMThYKpackN07ORpVmlqGjqFJzrIsrOMqKkbKHfRW9dJuhiuvUp1ecILslDKk
         CmPMG7HhDLe49+dNt6FHrtA+tUw2swXOC6VplvfPuIbLjGkjR6aj+utxYs2+5NRKdhoc
         5j2RDZCLOWv/2UnXAeU7aHd5WO07Cs1N24lMr9jCJS2qjiE5VC/ruxGSJte+E5GJAqIx
         OwgMhGo79zYqyPgMX0QvTwdL0fSK+VxsnTWLefmcyK4PJyE46h/1VZEXvad9MTfzjRCR
         RnVNhAlEFqwjcLDxHI65C0LcZKeB3zISVsWr7Vj4i1rO4tkuS3uY/0OIEDO3T9wOnlFC
         MqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qtn+wuGPbmDyYYGZWDOeGaLOLx9crboCVQLuM2/+veM=;
        b=5lCSss7uPlLyvCTi54g8Q08KjU4s2jCjisc+/GeHEWWXW1o83d6bpzwKGdLDGCFZ+u
         3SRc+vp5KiaJG8A2a6ZftEwh5p0sBu99EGGTQUR4NmNY/VylpuEh2JdOtPYjEPSuu5qG
         0tBfPJGUC+6Gi+8KynTyoQdFPbNxZZiT1aGClmjCx6qf0YPcJxCB4J3AMWW1maWwlboA
         dkcM3RZtxlYTCte/ZmHMm6H/vDm0WWKS/O1rLFyDs+7q6kHWm21yILOCxnfP14viFBvy
         28OSlOY6/ie2zQln0nX0A+1hSu46IsyFci0D4Hsrf1HhzXKWjwTuQjSEtMj+kRwJeZxE
         lKWg==
X-Gm-Message-State: AFqh2koeWAVjBLZF9AXAmoRjz2MArIPoJh4MsgR+W0x3fs9XCO2xJFQv
        6roSoYtmRjOcAM/S1iRVRoc=
X-Google-Smtp-Source: AMrXdXszgdx5vsNeNmkm9O6qZOv9csHrRVp1NCM31HLcIV93Ju6AWZgPHNdam1kkPaAtqECKT4h+eQ==
X-Received: by 2002:a05:6a00:be2:b0:56b:fa67:1f7f with SMTP id x34-20020a056a000be200b0056bfa671f7fmr57423687pfu.19.1673068650739;
        Fri, 06 Jan 2023 21:17:30 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g6-20020a625206000000b00576e4c7b9ecsm1907578pfb.214.2023.01.06.21.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 21:17:30 -0800 (PST)
Message-ID: <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
Date:   Sat, 7 Jan 2023 14:17:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, mliska@suse.cz,
        Akira Yokosawa <akiyks@gmail.com>
References: <87wn629ggg.fsf@meer.lwn.net>
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87wn629ggg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 13:45:35 -0700, Jonathan Corbet wrote:
> Sphinx 6.0 removed the execfile_() function, which we use as part of th=
e
> configuration process.  They *did* warn us...  Just open-code the
> functionality as is done in Sphinx itself.
>=20
> Tested (using SPHINX_CONF, since this code is only executed with an
> alternative config file) on various Sphinx versions from 2.5 through 6.=
0.
>=20
> Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

I have tested full builds of documentation with this change
with Sphinx versions 1.7.9, 2.4.5, 3.4.3, 4.5.0, 5.3.0, and 6.0.0.

Tested-by: Akira Yokosawa <akiyks@gmail.com>

That said, Sphinx 6.0.0 needs much more time and memory than earlier
versions.

FYI, I needed to limit parallel slot to 2 (make -j2) on a 16GB machine.
If you are lucky, -j3 and -j4 might succeed. -j5 or more ended up in
OOM situations for me:

Comparison of elapsed time and maxresident with -j2:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Sphinx version elapsed time maxresident
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  5.3.0          10:16.81      937660
  6.0.0          17:29.07     5292392
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

        Thanks, Akira

> ---
>  Documentation/sphinx/load_config.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx=
/load_config.py
> index eeb394b39e2c..8b416bfd75ac 100644
> --- a/Documentation/sphinx/load_config.py
> +++ b/Documentation/sphinx/load_config.py
> @@ -3,7 +3,7 @@
> =20
>  import os
>  import sys
> -from sphinx.util.pycompat import execfile_
> +from sphinx.util.osutil import fs_encoding
> =20
>  # --------------------------------------------------------------------=
----------
>  def loadConfig(namespace):
> @@ -48,7 +48,9 @@ def loadConfig(namespace):
>              sys.stdout.write("load additional sphinx-config: %s\n" % c=
onfig_file)
>              config =3D namespace.copy()
>              config['__file__'] =3D config_file
> -            execfile_(config_file, config)
> +            with open(config_file, 'rb') as f:
> +                code =3D compile(f.read(), fs_encoding, 'exec')
> +                exec(code, config)
>              del config['__file__']
>              namespace.update(config)
>          else:
> --=20
> 2.38.1
