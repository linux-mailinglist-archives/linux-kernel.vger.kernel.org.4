Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53426F940A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjEFVCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:02:09 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF840C7;
        Sat,  6 May 2023 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1683406910; i=aliakc@web.de;
        bh=Ayt8xy4rT0Xw3V4pKS4yIFdBYB0BoER4mhhWIMTOCXM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=b5xncVfT0Dbs8YWIV3mHnvLtm7ah/95MtTWaKkisXTFgXwxslfJGAjFlnz6jZJ8bU
         9Dwx2Y7D6cOanxmcub5dpvxKzBHdQtjOrp8NoZOyIzf+PMr+cYUhwTMe76v/Glbmqh
         //W+TRgu9skF+Sc6j+8g5A6AWd8KSLfqrG6RbtYCAeE5viSuEAeB1OXKmhhJ5sAiVk
         EBycpl9i9cD7GHxywdBeulkwsVuG52SEX925jg0rdJEsn0Wis1h068sr+sC6d1YvjW
         BkX1TYsWI/P5EZnOQEy8NxBoeXmhQQwm/KWWhhaMWP7H3Tng/6Qy+pRe7NItP+1rIc
         rgXvGA3bFBJbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from ulixys ([95.91.196.23]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1qcCYz3GQm-00jLEF; Sat, 06
 May 2023 23:01:49 +0200
Date:   Sat, 6 May 2023 23:01:43 +0200
From:   Ali Akcaagac <aliakc@web.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Drop DC395x list and site
Message-ID: <20230506230143.13969f82@ulixys>
In-Reply-To: <20230505082704.16228-2-bagasdotme@gmail.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
        <20230505082704.16228-2-bagasdotme@gmail.com>
X-Mailer: Claws Mail 4.1.1git999 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zVUr/Xdcx8CLnrXfPuLDZDbXaYHCkhB7LbwXolPronW+XQhEk00
 9CHgnUNzB+c7YCNwd8wSAJuUpDmNBLrUIYw8II5R+9ny7zCiveglY4vgXfen3DU3a2Z1lNL
 fXDES2T5UU6DTYPZ34FNkpt2WwgJlHiohnK0a6csu1UXPeK4t2MtDDHmDUv2vmpGG1VYosF
 pfgGgh/a1cgf5cUQMP1Qw==
UI-OutboundReport: notjunk:1;M01:P0:ELLbd5n2A1I=;oCofWlLB3RZeKhK5BxIWjo5pjdR
 EwM0neQEKTQHEVE7QdgUl13BdxB0ZU7ghrCBv7X/cP5w9z/50dFbxGPGrSqOa9I2bmbaWfmMb
 Sdz03ifVxhh0u0HtEaz/v+9IkwGZBL4ETOruTrRzCEKsFnjVqyyCYUa3BkLegGqIprBip6/2C
 BpAiAKYZIWZFT25YoT85YwgKO6Bxl5IdXmNiQYefGDF/tnN6PwxDaL8+FQzh80Gi5D+p1lQl1
 lb12epzS0tm34VfFXnEff5pAda2s/pFOtRVndD38+1/Y2PGL9UMJPzwdojUyh+CWwsGLahIJd
 +YXyEfUbLFVxUWDC2SuFAevmCbfYQRRuHG0EzA05H6K1+zIagG+H5U9JHc4E8lS6AKX0jl+Di
 T9+/eBK7xPHtNPitazauWqf/KS1SRcPhyEEig0S8ovDkSTPoRIrjZA2DLRf32YXInSyblTBuZ
 YvbMC/FCFrf6BANYGM5CJS3QOB72yxC7GTsZlS9r3qYqfwNaaC3ncRi2EtCEnj40aFxZJjzf6
 D6OZQADOH3yGWlc4YlHxsyJIE0S/lij1smsMDSk4lFpPJ897RoQQToPREqll6JwH68e99gUUU
 hGh0stY9gMqmNxV8T5zS/8a3K1bmTeHInRvkOmodBC7SLaTdzRMgW80pWD+OglYI6M1rP42PA
 aSY9KuBaA9mb+SY4x6I42KKKeHDmW3SrHH7kC3GTtr1uvct2KoL6C89y9SloSoKJDY2h43mZP
 q71UJLeIYa7J4E/937D4/kobyaVOcK+VXZE/X4vIRXIBD70H5E5vB7+TD2VQf2FMc0A3GAZJf
 sXAxrnM91VbEkI4Q8mCvPO4Rz4ET7fpyKdOVa9wU+p9lqDO2R2Xzl1Sr8Oih1zPOWgMfm4SHK
 KnnM+bzLcP8r1rPatjmINXheWMeSS26DuFNRSGzkvxzbq3BYDV1MyTVwWeJzFJzH7SBqEtE47
 I6y3brvEEEJsrT/TW1XgTVrbdb0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the dc395x list has gone long long looooong ago from what I recall. It
was set up during the transition phase from the 2.4.x Kernel to 2.5.x
-> 2.6.x where a few people wanted to communicate the changes necessary
to get that driver ported. I remember that it was around 2003 (more or
less) and I sometimes still wonder whether the hardware still exists,
still works or someone still uses it. It's funny to see that this kind
of topic is cooking up 20 years later :)

Regards

Ali

On Fri,  5 May 2023 15:27:02 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Emails to DC395x list bounce (550 error) and visiting the site returns
> 404 page.
>
> Drop both twibble.org links, replacing the list with linux-scsi list.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f3053b..35de3289a8af04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5692,10 +5692,8 @@ DC395x SCSI driver
>  M:	Oliver Neukum <oliver@neukum.org>
>  M:	Ali Akcaagac <aliakc@web.de>
>  M:	Jamie Lenehan <lenehan@twibble.org>
> -L:	dc395x@twibble.org
> +L:	linux-scsi@vger.kernel.org
>  S:	Maintained
> -W:	http://twibble.org/dist/dc395x/
> -W:	http://lists.twibble.org/mailman/listinfo/dc395x/
>  F:	Documentation/scsi/dc395x.rst
>  F:	drivers/scsi/dc395x.*
>

