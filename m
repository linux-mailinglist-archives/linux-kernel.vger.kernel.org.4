Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4815D7147C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjE2KO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:14:57 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C84B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:14:55 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685355294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5U83pgtUbdNZXbGC3fVAgoMj9cpM77Fj84QM02uyq8=;
        b=B6mAEL3uE7AHcxPnr4g5M93WAGfGZObq/ytl1vRxrauyVvX4RT+2UqQmz3pCzyxKpSh7O4
        f6zi5R2Xkh+WkOyBfr1l7CLfBI5fDHB8F1VmK/aKlIxMiTCgTTT+rCzr3jjMiBmeNREFbN
        xtnlfzZy3giBu9wC1ITJhZZnrxE5BaQd/B2HJB2yPnWDy9JK1UNQsnx9cVfQmTHRUuPpYi
        lTImpP+8POay4K4xgQQuwdYW6sSUwXKKMiHXFBJGF6eygMxdU0NyxtiGuTtdoopWGq35nw
        BwPQrG7lhQucPYs62utQHO5CW/ZgQjydTPfHctShicr5PjU1Zm6CV7XrwoE8yw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41E30240002;
        Mon, 29 May 2023 10:14:53 +0000 (UTC)
Date:   Mon, 29 May 2023 12:14:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230529121452.3a2f33f2@xps-13>
In-Reply-To: <8c442b03-bff3-4d25-96e0-eb297e280797@kili.mountain>
References: <20230523100239.307574-3-miquel.raynal@bootlin.com>
        <8c442b03-bff3-4d25-96e0-eb297e280797@kili.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

dan.carpenter@linaro.org wrote on Mon, 29 May 2023 07:28:59 +0300:

> Hi Miquel,
>=20
> kernel test robot noticed the following build warnings:
>=20
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/ABI-=
sysfs-nvmem-cells-Expose-cells-through-sysfs/20230523-203042
> base:   char-misc/char-misc-testing
> patch link:    https://lore.kernel.org/r/20230523100239.307574-3-miquel.r=
aynal%40bootlin.com
> patch subject: [PATCH 2/2] nvmem: core: Expose cells through sysfs
> config: i386-randconfig-m021-20230525 (https://download.01.org/0day-ci/ar=
chive/20230528/202305280054.NloN5RLk-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202305280054.NloN5RLk-lkp@intel.com/
>=20
> smatch warnings:
> drivers/nvmem/core.c:380 nvmem_cell_attr_read() error: uninitialized symb=
ol 'read_len'.
>=20
> vim +/read_len +380 drivers/nvmem/core.c
>=20
> 22c370b2163e59 Miquel Raynal       2023-05-23  328  static struct nvmem_c=
ell *nvmem_create_cell(struct nvmem_cell_entry *entry,
> 22c370b2163e59 Miquel Raynal       2023-05-23  329  					    const char *=
id, int index);
> 22c370b2163e59 Miquel Raynal       2023-05-23  330 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  331  static ssize_t nvmem_=
cell_attr_read(struct file *filp, struct kobject *kobj,
> 22c370b2163e59 Miquel Raynal       2023-05-23  332  				    struct bin_at=
tribute *attr, char *buf,
> 22c370b2163e59 Miquel Raynal       2023-05-23  333  				    loff_t pos, s=
ize_t count)
> 22c370b2163e59 Miquel Raynal       2023-05-23  334  {
> 22c370b2163e59 Miquel Raynal       2023-05-23  335  	struct nvmem_cell_en=
try *entry;
> 22c370b2163e59 Miquel Raynal       2023-05-23  336  	struct nvmem_cell *c=
ell =3D NULL;
> 22c370b2163e59 Miquel Raynal       2023-05-23  337  	struct nvmem_device =
*nvmem;
> 22c370b2163e59 Miquel Raynal       2023-05-23  338  	size_t cell_sz, read=
_len;
> 22c370b2163e59 Miquel Raynal       2023-05-23  339  	struct device *dev;
> 22c370b2163e59 Miquel Raynal       2023-05-23  340  	void *content;
> 22c370b2163e59 Miquel Raynal       2023-05-23  341 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  342  	if (attr->private)
> 22c370b2163e59 Miquel Raynal       2023-05-23  343  		dev =3D attr->priva=
te;
> 22c370b2163e59 Miquel Raynal       2023-05-23  344  	else
> 22c370b2163e59 Miquel Raynal       2023-05-23  345  		dev =3D kobj_to_dev=
(kobj);
> 22c370b2163e59 Miquel Raynal       2023-05-23  346  	nvmem =3D to_nvmem_d=
evice(dev);
> 22c370b2163e59 Miquel Raynal       2023-05-23  347 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  348  	mutex_lock(&nvmem_mu=
tex);
> 22c370b2163e59 Miquel Raynal       2023-05-23  349  	list_for_each_entry(=
entry, &nvmem->cells, node) {
> 22c370b2163e59 Miquel Raynal       2023-05-23  350  		if (strncmp(entry->=
name, attr->attr.name, XATTR_NAME_MAX))
> 22c370b2163e59 Miquel Raynal       2023-05-23  351  			continue;
> 22c370b2163e59 Miquel Raynal       2023-05-23  352 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  353  		cell =3D nvmem_crea=
te_cell(entry, entry->name, 0);
> 22c370b2163e59 Miquel Raynal       2023-05-23  354  		if (IS_ERR(cell)) {
> 22c370b2163e59 Miquel Raynal       2023-05-23  355  			mutex_unlock(&nvme=
m_mutex);
> 22c370b2163e59 Miquel Raynal       2023-05-23  356  			return PTR_ERR(cel=
l);
> 22c370b2163e59 Miquel Raynal       2023-05-23  357  		}
> 22c370b2163e59 Miquel Raynal       2023-05-23  358 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  359  		break;
> 22c370b2163e59 Miquel Raynal       2023-05-23  360  	}
> 22c370b2163e59 Miquel Raynal       2023-05-23  361  	mutex_unlock(&nvmem_=
mutex);
> 22c370b2163e59 Miquel Raynal       2023-05-23  362 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  363  	if (!cell)
> 22c370b2163e59 Miquel Raynal       2023-05-23  364  		return -EINVAL;
> 22c370b2163e59 Miquel Raynal       2023-05-23  365 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  366  	content =3D nvmem_ce=
ll_read(cell, &cell_sz);
> 22c370b2163e59 Miquel Raynal       2023-05-23  367  	if (IS_ERR(content))=
 {
> 22c370b2163e59 Miquel Raynal       2023-05-23  368  		count =3D PTR_ERR(c=
ontent);
> 22c370b2163e59 Miquel Raynal       2023-05-23  369  		goto destroy_cell;
>=20
> read_len not initialized on this goto path.

It should be:							read_len =3D PTR_ERR...

I will correct this in the next version, thanks for the report.

>=20
> 22c370b2163e59 Miquel Raynal       2023-05-23  370  	}
> 22c370b2163e59 Miquel Raynal       2023-05-23  371 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  372  	read_len =3D min_t(u=
nsigned int, cell_sz - pos, count);
> 22c370b2163e59 Miquel Raynal       2023-05-23  373  	memcpy(buf, content =
+ pos, read_len);
> 22c370b2163e59 Miquel Raynal       2023-05-23  374  	kfree(content);
> 22c370b2163e59 Miquel Raynal       2023-05-23  375 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23  376  destroy_cell:
> 22c370b2163e59 Miquel Raynal       2023-05-23  377  	kfree_const(cell->id=
);
> 22c370b2163e59 Miquel Raynal       2023-05-23  378  	kfree(cell);
> 22c370b2163e59 Miquel Raynal       2023-05-23  379 =20
> 22c370b2163e59 Miquel Raynal       2023-05-23 @380  	return read_len;
>                                                         ^^^^^^^^^^^^^^^
>=20
> 22c370b2163e59 Miquel Raynal       2023-05-23  381  }
>=20


Thanks,
Miqu=C3=A8l
