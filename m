Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64737083F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjERObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:31:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F9109
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:31:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078aa0b152so1412830f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684420289; x=1687012289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZaWq3HU9wnU7dMN1Rvidialy13n5vzNtw5K7hiWVFo=;
        b=gDfguZYCaicvfknKAJyvSjpa9zlIa7YAoxOZurvxbT5P0KPfE9+/KtKLVXT/hEOv++
         Si2SUcPcNYvdySjr+e4KfCdNUkxjLx6UL23QqrP+Tmy7KJKvShxPABGiaaMFSPJKX9zm
         dU11dbizySDuW4Rf5LcJGnc1n224lqIsUoi2GEXxV4bAGERfdEqkSSq1QvaosIQxXgO4
         NDmXm7fH4/CT1lRT7yaFv3Z0RGVud2XpyLhjj7YXQ2M+45JtGNvRtVrWz8HGCT5leEQM
         3lrhOTIG5j/cuyGXh5jCGzWdjcPcaUinCCHjIDas+EAfjjxBL+Ujyyg22v+zijW16Zkh
         wsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684420289; x=1687012289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZaWq3HU9wnU7dMN1Rvidialy13n5vzNtw5K7hiWVFo=;
        b=APxeFtHF0xOkKCiRZYfWsUG+Q9KRi9yuoGVHgOCRLSfXZAS+Zwt3aU0CJFu9GRMiMI
         AMnoZFI36ld4yo0s5h7+2WiK/C9fEoCSgDJFnDUo54M3PlR5ofpXcLRfqHzMMa0u0kpP
         llMZPKhInCPIHsRJc+2uOn5u/ewpnT7ae8FzgYSW6BwJiEf7PUCVTKs4jgCR06eBWkCu
         3MD6jA/Yidx7L6aa+l+/9P0sv1naPb0dCd1At0DtQnwbt2RsAR4eRnlXwPgx+iul6hGU
         yVDEMqhYKOp9UdF+CGIwECUic9zDs0FGnOjxHfwGgLorF0jQZu6VQUJVibFAA9QaJ5bh
         ewTg==
X-Gm-Message-State: AC+VfDzrezSKVVvZUZzAq/CsZW1ceoXo2mLMWFpUm/HhptoS61mo98pI
        F50kL8wpakmW+Kri5CtO7BunD4xkYOU5Fj4pqKg=
X-Google-Smtp-Source: ACHHUZ6YQUOidMpilPCpkUhLXOyzCGw+3ifJ6O3MJtfnkV7xLmnKH4dcdptCxMD8gcTuKVm7X4pByqxz2b90AHzl1vQ=
X-Received: by 2002:adf:fa01:0:b0:309:38f4:fb45 with SMTP id
 m1-20020adffa01000000b0030938f4fb45mr1419342wrr.46.1684420288801; Thu, 18 May
 2023 07:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230514130148.138624-2-prathubaronia2011@gmail.com> <30f4e6ff-5ad3-4b57-b7c7-228b97369b72@kili.mountain>
In-Reply-To: <30f4e6ff-5ad3-4b57-b7c7-228b97369b72@kili.mountain>
From:   Prathu Baronia <prathubaronia2011@gmail.com>
Date:   Thu, 18 May 2023 20:01:17 +0530
Message-ID: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, gregkh@linuxfoundation.org,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for pointing these out. The older warning seems to be
introduced in an earlier commit. I will fix both of these in v3.
---
- Prathu


On Mon, May 15, 2023 at 1:13=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi Prathu,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Prathu-Baronia/axi=
s-fifo-cleanup-space-issues-with-fops-struct/20230514-220201
> base:   staging/staging-testing
> patch link:    https://lore.kernel.org/r/20230514130148.138624-2-prathuba=
ronia2011%40gmail.com
> patch subject: [PATCH v2 1/2] axis-fifo: use devm_kasprintf() for allocat=
ing formatted strings
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202305150358.nt1BkbXz-lkp@intel.com/
>
> New smatch warnings:
> drivers/staging/axis-fifo/axis-fifo.c:858 axis_fifo_probe() warn: missing=
 unwind goto?
>
> Old smatch warnings:
> drivers/staging/axis-fifo/axis-fifo.c:907 axis_fifo_probe() error: '%pa' =
expects argument of type 'phys_addr_t*', argument 4 has type 'void**'
>
> vim +858 drivers/staging/axis-fifo/axis-fifo.c
>
> 4a965c5f89decd Jacob Feder        2018-07-22  806  static int axis_fifo_p=
robe(struct platform_device *pdev)
> 4a965c5f89decd Jacob Feder        2018-07-22  807  {
> 4a965c5f89decd Jacob Feder        2018-07-22  808       struct resource *=
r_mem; /* IO mem resources */
> 4a965c5f89decd Jacob Feder        2018-07-22  809       struct device *de=
v =3D &pdev->dev; /* OS device (from device tree) */
> 4a965c5f89decd Jacob Feder        2018-07-22  810       struct axis_fifo =
*fifo =3D NULL;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  811       char *device_name=
;
> 4a965c5f89decd Jacob Feder        2018-07-22  812       int rc =3D 0; /* =
error return value */
> 4a965c5f89decd Jacob Feder        2018-07-22  813
> 4a965c5f89decd Jacob Feder        2018-07-22  814       /* --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  815        *     init wrapp=
er device
> 4a965c5f89decd Jacob Feder        2018-07-22  816        * --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  817        */
> 4a965c5f89decd Jacob Feder        2018-07-22  818
> 4a965c5f89decd Jacob Feder        2018-07-22  819       /* allocate devic=
e wrapper memory */
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  820       fifo =3D devm_kza=
lloc(dev, sizeof(*fifo), GFP_KERNEL);
> 4a965c5f89decd Jacob Feder        2018-07-22  821       if (!fifo)
> 4a965c5f89decd Jacob Feder        2018-07-22  822               return -E=
NOMEM;
> 4a965c5f89decd Jacob Feder        2018-07-22  823
> 4a965c5f89decd Jacob Feder        2018-07-22  824       dev_set_drvdata(d=
ev, fifo);
> 4a965c5f89decd Jacob Feder        2018-07-22  825       fifo->dt_device =
=3D dev;
> 4a965c5f89decd Jacob Feder        2018-07-22  826
> 4a965c5f89decd Jacob Feder        2018-07-22  827       init_waitqueue_he=
ad(&fifo->read_queue);
> 4a965c5f89decd Jacob Feder        2018-07-22  828       init_waitqueue_he=
ad(&fifo->write_queue);
> 4a965c5f89decd Jacob Feder        2018-07-22  829
> 0443b3f4436321 Quentin Deslandes  2020-01-21  830       mutex_init(&fifo-=
>read_lock);
> 0443b3f4436321 Quentin Deslandes  2020-01-21  831       mutex_init(&fifo-=
>write_lock);
> 4a965c5f89decd Jacob Feder        2018-07-22  832
> 4a965c5f89decd Jacob Feder        2018-07-22  833       /* --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  834        *   init device =
memory space
> 4a965c5f89decd Jacob Feder        2018-07-22  835        * --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  836        */
> 4a965c5f89decd Jacob Feder        2018-07-22  837
> 4a965c5f89decd Jacob Feder        2018-07-22  838       /* get iospace fo=
r the device */
> 4a965c5f89decd Jacob Feder        2018-07-22  839       r_mem =3D platfor=
m_get_resource(pdev, IORESOURCE_MEM, 0);
> 4a965c5f89decd Jacob Feder        2018-07-22  840       if (!r_mem) {
> 4a965c5f89decd Jacob Feder        2018-07-22  841               dev_err(f=
ifo->dt_device, "invalid address\n");
> 4a965c5f89decd Jacob Feder        2018-07-22  842               rc =3D -E=
NODEV;
> 4a965c5f89decd Jacob Feder        2018-07-22  843               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  844       }
> 4a965c5f89decd Jacob Feder        2018-07-22  845
> 4a965c5f89decd Jacob Feder        2018-07-22  846       /* request physic=
al memory */
> 354e27a86b4c64 Quentin Deslandes  2019-11-01  847       fifo->base_addr =
=3D devm_ioremap_resource(fifo->dt_device, r_mem);
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  848       if (IS_ERR(fifo->=
base_addr)) {
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  849               rc =3D PT=
R_ERR(fifo->base_addr);
> 4a965c5f89decd Jacob Feder        2018-07-22  850               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  851       }
> 4a965c5f89decd Jacob Feder        2018-07-22  852
> 4a965c5f89decd Jacob Feder        2018-07-22  853       dev_dbg(fifo->dt_=
device, "remapped memory to 0x%p\n", fifo->base_addr);
> 4a965c5f89decd Jacob Feder        2018-07-22  854
> 4a965c5f89decd Jacob Feder        2018-07-22  855       /* create unique =
device name */
> c5cab4f62648eb Prathu Baronia     2023-05-14  856       device_name =3D d=
evm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
> c5cab4f62648eb Prathu Baronia     2023-05-14  857       if (!device_name)
> c5cab4f62648eb Prathu Baronia     2023-05-14 @858               return -E=
NOMEM;
>
>                 rc =3D -ENOMEM;
>                 goto err_initial;
>
> 4a965c5f89decd Jacob Feder        2018-07-22  859       dev_dbg(fifo->dt_=
device, "device name [%s]\n", device_name);
> 4a965c5f89decd Jacob Feder        2018-07-22  860
> 4a965c5f89decd Jacob Feder        2018-07-22  861       /* --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  862        *          init =
IP
> 4a965c5f89decd Jacob Feder        2018-07-22  863        * --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  864        */
> 4a965c5f89decd Jacob Feder        2018-07-22  865
> ed6daf2b2832d9 Quentin Deslandes  2019-11-01  866       rc =3D axis_fifo_=
parse_dt(fifo);
> 4a965c5f89decd Jacob Feder        2018-07-22  867       if (rc)
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  868               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  869
> 4a965c5f89decd Jacob Feder        2018-07-22  870       reset_ip_core(fif=
o);
> 4a965c5f89decd Jacob Feder        2018-07-22  871
> 4a965c5f89decd Jacob Feder        2018-07-22  872       /* --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  873        *    init device=
 interrupts
> 4a965c5f89decd Jacob Feder        2018-07-22  874        * --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  875        */
> 4a965c5f89decd Jacob Feder        2018-07-22  876
> 4a965c5f89decd Jacob Feder        2018-07-22  877       /* get IRQ resour=
ce */
> 790ada0e6ec33e Lad Prabhakar      2021-12-24  878       rc =3D platform_g=
et_irq(pdev, 0);
> 790ada0e6ec33e Lad Prabhakar      2021-12-24  879       if (rc < 0)
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  880               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  881
> 4a965c5f89decd Jacob Feder        2018-07-22  882       /* request IRQ */
> 790ada0e6ec33e Lad Prabhakar      2021-12-24  883       fifo->irq =3D rc;
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  884       rc =3D devm_reque=
st_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  885                        =
     DRIVER_NAME, fifo);
> 4a965c5f89decd Jacob Feder        2018-07-22  886       if (rc) {
> 4a965c5f89decd Jacob Feder        2018-07-22  887               dev_err(f=
ifo->dt_device, "couldn't allocate interrupt %i\n",
> 4a965c5f89decd Jacob Feder        2018-07-22  888                       f=
ifo->irq);
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  889               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  890       }
> 4a965c5f89decd Jacob Feder        2018-07-22  891
> 4a965c5f89decd Jacob Feder        2018-07-22  892       /* --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  893        *      init char=
 device
> 4a965c5f89decd Jacob Feder        2018-07-22  894        * --------------=
--------------
> 4a965c5f89decd Jacob Feder        2018-07-22  895        */
> 4a965c5f89decd Jacob Feder        2018-07-22  896
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  897       /* create charact=
er device */
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  898       fifo->miscdev.fop=
s =3D &fops;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  899       fifo->miscdev.min=
or =3D MISC_DYNAMIC_MINOR;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  900       fifo->miscdev.nam=
e =3D device_name;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  901       fifo->miscdev.gro=
ups =3D axis_fifo_attrs_groups;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  902       fifo->miscdev.par=
ent =3D dev;
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  903       rc =3D misc_regis=
ter(&fifo->miscdev);
> 4a965c5f89decd Jacob Feder        2018-07-22  904       if (rc < 0)
> 6a20d283ed6867 Quentin Deslandes  2019-11-01  905               goto err_=
initial;
> 4a965c5f89decd Jacob Feder        2018-07-22  906
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  907       dev_info(fifo->dt=
_device, "axis-fifo created at %pa mapped to 0x%pa, irq=3D%i\n",
>                                                                          =
                                             ^^^^^
> d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  908                &r_mem->=
start, &fifo->base_addr, fifo->irq);
>                                                                          =
       ^^^^^^^^^^^^^^^^
> I think Smatch is correct that it should just be %p instead of %pa but
> I don't know the rules here too well.
>
> 4a965c5f89decd Jacob Feder        2018-07-22  909
> 4a965c5f89decd Jacob Feder        2018-07-22  910       return 0;
> 4a965c5f89decd Jacob Feder        2018-07-22  911
> 4a965c5f89decd Jacob Feder        2018-07-22  912  err_initial:
> 4a965c5f89decd Jacob Feder        2018-07-22  913       dev_set_drvdata(d=
ev, NULL);
> 4a965c5f89decd Jacob Feder        2018-07-22  914       return rc;
> 4a965c5f89decd Jacob Feder        2018-07-22  915  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
