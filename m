Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C366800AC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjA2SKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2SKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:10:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38671BFC;
        Sun, 29 Jan 2023 10:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68ACEB80D1C;
        Sun, 29 Jan 2023 18:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49F2C433EF;
        Sun, 29 Jan 2023 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675015848;
        bh=k0hsvYRx1ao42BSumJbzYaoT9YdkFlwNnK36l1XcopM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLeeI3474urH2XJ+VNuFNcBx4mxPF8wQfpPnf9YN/flmxnOB+rwRITr/FF7qy5ic7
         zZmDk3IHAKu9soQ508NuvW7W9zIrduScZ4xf7/ropGzDk6KHo/4ADpQc1c6j/5nabG
         E6uexd1/CasW7oP1cicqFCzTYzIPp0yfKW+38TKPZ6+7Mg4Y+QiiO6ws16OojRRVRr
         lE0brjAsVrJcg8Vb6RorB04wlbMSEYJe3qkoRuAwpdJZ4fcDy5mhbBxSSNintlxCzW
         bZBUCp6uUwsXyOPG4GUMRAHIJCf8/cv6oTz5SvuzKyP+QlGXrUMbZoz8Z/C77tEh6t
         /N8jMpt36oTtg==
Date:   Sun, 29 Jan 2023 18:24:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     lorenzo@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, carnil@debian.org
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
Message-ID: <20230129182441.082f29d0@jic23-huawei>
In-Reply-To: <CAMxBKG1670TFuV3nHP7Yk8s6H+oBF7iiyiB-b=PvKv9hcH22xQ@mail.gmail.com>
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
        <Y9WGmBc9HG4Tx9gf@eldamar.lan>
        <CAMxBKG1670TFuV3nHP7Yk8s6H+oBF7iiyiB-b=PvKv9hcH22xQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 17:03:51 +0000
Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:

> Hi,
> 
> I raised this bug in Debian, and have been asked to raise it upstream and
> was given your addresses to do so. Will this email be OK, or should I raise
> it in a bug tracking system somewhere?

Email is the right option.

> 
> Many thanks,
> Darrell
> 
> 
> 
> 
> ---------- Forwarded message ---------
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Sat, 28 Jan 2023 at 20:33
> Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
> LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
> To: Darrell Kavanagh <darrell.kavanagh@gmail.com>, <1029850@bugs.debian.org>
> 
> 
> Hi Darrell,
> 
> On Sat, Jan 28, 2023 at 08:13:16PM +0000, Darrell Kavanagh wrote:
> > Package: src:linux
> > Version: 6.1.4-1
> > Severity: normal
> > File: linux
> > X-Debbugs-Cc: darrell.kavanagh@gmail.com
> >
> > Dear Maintainer,
> >
> > This is a convertable touchscreen tablet/laptop. The rotation sensor  
> device
> > ST Microelectronics LSM6DS3TR-C does not work. It is detected via ACPI  
> and the
> > sysfs trees are created at  
> devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-SMO8B30:00
> > and devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:3c/SMO8B30:00 with
> > symlinks bus/acpi/devices/SMO8B30:00 and bus/i2c/devices/i2c-SMO8B30:00,  
> but
> > no driver is loaded.

At least this is using the ST PNP ID which is better than average
(long story!)

The driver in question (ultimately drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
does not currently have an ACPI support.  It should be straight forwards
to add though the driver first needs converting to use
device_get_match_data() with appropriate fallback so that it will match on
ACPI, OF or original spi_device_id tables

Completely untested but something like the following
(the offset in the enum is needed to allow us to tell if we got a result when
calling device_get_match_data() as it returns NULL on failure IIRC)

I'm not sure how sucessful the driver will be at finding any interrupts etc, but
it may get you basic functionality.

Good luck and others more familiar with the driver may well tell me what I forgot
when hacking the below ;)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 499fcf8875b4..2617ce236ddc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -39,7 +39,7 @@
 #define ST_ISM330IS_DEV_NAME   "ism330is"
 
 enum st_lsm6dsx_hw_id {
-       ST_LSM6DS3_ID,
+       ST_LSM6DS3_ID = 1,
        ST_LSM6DS3H_ID,
        ST_LSM6DSL_ID,
        ST_LSM6DSM_ID,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index df5f60925260..ecfceb2fb3db 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -23,10 +23,15 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
 
 static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
 {
-       const struct i2c_device_id *id = i2c_client_get_device_id(client);
-       int hw_id = id->driver_data;
+       int hw_id;
        struct regmap *regmap;
 
+       hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
+       if (!hw_id)
+               hw_id = i2c_client_get_device_id(client)->driver_data;
+       if (!hw_id)
+               return -EINVAL;
+
        regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
        if (IS_ERR(regmap)) {
                dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
@@ -129,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
+static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
+       { "SMO8B30", ST_LSM6DS3TRC_ID, },
+};
+
 static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
        { ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
        { ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
@@ -161,6 +170,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
                .name = "st_lsm6dsx_i2c",
                .pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
                .of_match_table = st_lsm6dsx_i2c_of_match,
+               .acpi_match_table = st_lsm6dsx_i2c_acpi_match,
        },
        .probe_new = st_lsm6dsx_i2c_probe,
        .id_table = st_lsm6dsx_i2c_id_table,


> >
> > The device is identifying itself to the kernel with PNP id SMO8B30:
> > physical_node:
> >       modalias=acpi:SMO8B30:SMO8B30:
> >       name=SMO8B30:00
> >       uevent=MODALIAS=acpi:SMO8B30:SMO8B30:
> >       waiting_for_supplier=0
> > firmware_node:
> >       hid=SMO8B30
> >       modalias=acpi:SMO8B30:SMO8B30:
> >       path=\_SB_.PCI0.I2C5.DEV_
> >       status=15
> >       uevent=MODALIAS=acpi:SMO8B30:SMO8B30:
> >       uid=0
> >
> > The kernel module for the appropriate driver (st_lsm6dsx_i2c) is not  
> loaded on boot.
> > Modprobing it does not associate it with the device, as I would expect as
> > the module does not provide an alias for the above acpi/pnp id.  
> 
> Can you report this issue upstream? Gues to reach out are according to
> get_maintainers.pl script:
> 
> Lorenzo Bianconi <lorenzo@kernel.org> (maintainer:ST LSM6DSx IMU IIO DRIVER)
> Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS)
> Lars-Peter Clausen <lars@metafoo.de> (reviewer:IIO SUBSYSTEM AND DRIVERS)
> linux-iio@vger.kernel.org (open list:ST LSM6DSx IMU IIO DRIVER)
> linux-kernel@vger.kernel.org (open list)
> 
> Please keep us in the loop.
> 
> Regards,
> Salvatore

