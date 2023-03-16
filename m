Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5E6BD279
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCPOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCPOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:38:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A352449C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:38:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ip21-20020a05600ca69500b003ed56690948so1241820wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678977485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XI2eVpcSqFKSHDGu+9LYbNws8P+6loDyR+TV4ZvW3A=;
        b=HKsitrd+G0kWMpEMONYvYJmlCBcc6tJqNN3kBHfa6iI1lyQSHnNWu+Kdm6O64CXU51
         743AVWmJlGKig4XLFSxsvGy7RD9AlqMK1OPf38nA0cyQhleEIKisKeNkd8WS4fR0gEqe
         oGAl10oNulEehq55wgL8Vajh1hq21PBoUPHhBf9QoIiZVgUd/f7nPjYHcPEPwMgAPoNY
         EChQNsc257ua550LS+fMqT+V2WLprGyAsSE6TXFDLHOEQWtmJ9WPD/Ngk/qtnXgy94j8
         lxFVllLGHGuXpRAjTv3s7MejRnSLm3Sin4uQ1ZxGRUbfA/SF9lLj8UNM0u5mcRcfBa6d
         y8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XI2eVpcSqFKSHDGu+9LYbNws8P+6loDyR+TV4ZvW3A=;
        b=yXJIvy4cz3toL4+GsrRdUMHX4lM48uweCkVwtaKz+usI5sCena2tPAldoL3iJtbH8+
         NmC50fgWIg0fTbdXd+TD/miHwF5OZvnQK1u4Ke4BdgXpA1Y0dVaX/J3bMsPEbJy0E0vm
         ZOHPgFtDWjDoR7hz3JIfcPOdZfTI0+37alZA+HPjCOe33Eo1w0/OlZQnqaE+nbFVaQLv
         ChQRcLoMsyEmt5BhxHKpNsnSH3C97HzrKJ19loNExn1A9dCkZwfYCRoy7Idtfkj5V1Z4
         9R92lEn/5MyZkdxrhlReOU44CNhf220hFK3cNTSxAsTPpmKqK6WQH/eWmTGzkT8+hB/Y
         5+kg==
X-Gm-Message-State: AO0yUKVeLBJtQdrsVVjBRL40Ggtpt7OzRxI/1ef7uhaGqv0AEvxmpuhE
        eOx3ZVw25WAnvemRQbN2GFV0JuvUkbM=
X-Google-Smtp-Source: AK7set8cHSx4IMY0EXpFhkBXQ/3jjZmYb/PSePIpVVMnxy7TVy2mMgO4Z7ENQy8sBZg8NwiGX9p0DQ==
X-Received: by 2002:a05:600c:310e:b0:3e9:f15b:935b with SMTP id g14-20020a05600c310e00b003e9f15b935bmr22624237wmo.32.1678977484994;
        Thu, 16 Mar 2023 07:38:04 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc31a000000b003eb596cbc54sm5302340wmj.0.2023.03.16.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:38:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy@lists.linux.dev,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 15:38:03 +0100
Message-ID: <2626731.BddDVKsqQX@suse>
In-Reply-To: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija,

Just saw your v5 patch and Greg's two replies.

=46or v6 you will need to change the subject to "[PATCH v6] staging: axis-f=
ifo:=20
initialize timeouts in init only" to indicate that you are doing assignment=
s=20
in axis_fifo_init().

Don't forget to extend the version log with "Changes in v6:" and clarify th=
at=20
v5 had a different "Object" (you should probably also add a link to the v5=
=20
patch in lore: https://lore.kernel.org/lkml /ZBMR4s8xyHGqMm72@khadija-virtu=
al-
machine/). When the "Subject" changes, readers may not find the previous=20
versions easily.   =20

On gioved=EC 16 marzo 2023 13:56:02 CET Khadija Kamran wrote:
> Module parameter, read_timeout, can only be set at the loading time. As
> it can only be modified once, initialize read_timeout once in the probe

Substitute "probe" with "init".

> function.
>=20
> As a result, only use read_timeout as the last argument in
> wait_event_interruptible_timeout() call.

This two sentences are not much clear. I'd merge and rework:

"Initialize the module parameters read_timeout and write_timeout once in=20
init().

Module parameters can only be set once and cannot be modified later, so we=
=20
don't need to evaluate them again when passing the parameters to =20
wait_event_interruptible_timeout()."  =20

>=20
> Convert datatpe

s/datatpe/type/

> of read_timeout

of {read,write}_timeout

> from 'int' to 'long int' because
> implicit conversion of 'long int' to 'int' in statement 'read_timeout =3D
> MAX_SCHEDULE_TIMEOUT' results in an overflow warning.

We don't care too much about the warning themselves: I mean, it overflows a=
nd=20
you must avoid it to happen (as you are doing with the changes of types), n=
ot=20
merely be interested in avoiding the warning. "[] results in an overflow." =
is=20
all we care about.

Add also the previous paragraph in the last part of the commit message.
=20
> Perform same steps formodule parameter, write_timeout.

And instead delete the this last phrase.

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>=20
> Changes in v5:
>  - Convert timeout's datatype from int to long.
> Changes in v4:
>  - Initialize timeouts once as suggested by Greg; this automatically
>    fixes the indentation problems.
>  - Change the subject and description.
> Changes in v3:
>  - Fix grammatical mistakes
>  - Do not change the second argument's indentation in split lines
> Changes in v2:
>  - Instead of matching alignment to open parenthesis, align second and
>    the last argument instead.
>  - Change the subject to 'remove tabs to align arguments'.
>  - Use imperative language in subject and description
>=20
>  drivers/staging/axis-fifo/axis-fifo.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> b/drivers/staging/axis-fifo/axis-fifo.c index dfd2b357f484..d667dc80df47
> 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -103,17 +103,17 @@
>   *           globals
>   * ----------------------------
>   */
> -static int read_timeout =3D 1000; /* ms to wait before read() times out =
*/
> -static int write_timeout =3D 1000; /* ms to wait before write() times ou=
t */
> +static long read_timeout =3D 1000; /* ms to wait before read() times out=
 */
> +static long write_timeout =3D 1000; /* ms to wait before write() times o=
ut */
>=20
>  /* ----------------------------
>   * module command-line arguments
>   * ----------------------------
>   */
>=20
> -module_param(read_timeout, int, 0444);
> +module_param(read_timeout, long, 0444);
>  MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing=
=20
out;
> set to -1 for no timeout"); -module_param(write_timeout, int, 0444);
> +module_param(write_timeout, long, 0444);
>  MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timi=
ng
> out; set to -1 for no timeout");
>=20
>  /* ----------------------------
> @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char=20
__user
> *buf, mutex_lock(&fifo->read_lock);
>  		ret =3D wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >=3D 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			read_timeout);
>=20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {
> @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const=
=20
char
> __user *buf, ret =3D wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>=20
>  				 >=3D words_to_write,

What is this? You haven't yet compiled your patch.
Any further problems with enabling axis-fifo as a module?

=46abio

>=20
> -				 (write_timeout >=3D 0) ?
> -				  msecs_to_jiffies(write_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			write_timeout);
>=20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {
> @@ -815,6 +811,16 @@ static int axis_fifo_probe(struct platform_device=20
*pdev)
>  	char *device_name;
>  	int rc =3D 0; /* error return value */
>=20
> +	if (read_timeout >=3D 0)
> +		read_timeout =3D msecs_to_jiffies(read_timeout);
> +	else
> +		read_timeout =3D MAX_SCHEDULE_TIMEOUT;
> +
> +	if (write_timeout >=3D 0)
> +		write_timeout =3D msecs_to_jiffies(write_timeout);
> +	else
> +		write_timeout =3D MAX_SCHEDULE_TIMEOUT;
> +
>  	/* ----------------------------
>  	 *     init wrapper device
>  	 * ----------------------------
> --
> 2.34.1




