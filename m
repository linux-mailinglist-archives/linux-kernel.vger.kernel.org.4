Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446D6195BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDMCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKDMBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:01:50 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9CF2A406;
        Fri,  4 Nov 2022 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667563290; bh=YPtVAYdEXx8i1IqVFxOaEx4OHXULptxJaVd+6m0sNS4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Ae8o+1mGNoQo+M811F7prUxM7U7ewnLmNUUgif7ucBtmoK37UdYs1sQASWogMSpk5
         BU2Q/pFhMFHfrEpTpmdR1oSqDgno4eJH3sT+3Mvwf21HIPeAax/kxoiTPXGjIhfLFj
         sh19qspZ4whb6OoeGWPwIZ3qlgiFmmbDRE+eje38=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 13:01:30 +0100 (CET)
X-EA-Auth: RKOMhKgnDYEkcwR2C1jUfpukTrMkM9CT5k93jTVD2RfACxrD4GmkzSXe/I44EP5fTeY2OAgi5F7UPu1DPCFQvjMSblKoagZy
Date:   Fri, 4 Nov 2022 17:31:24 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y2T/FA0Ws9ExS+uz@qemulion>
References: <Y1vZXUi0Bjiub8HZ@ubunlion>
 <Y1zXIjCe3LGwApWD@kroah.com>
 <Y11b0oCmle2pbRel@ubunlion>
 <alpine.DEB.2.22.394.2210291931590.2917@hadrien>
 <Y191LI7zKVRA5LEb@ubunlion>
 <Y1+YC5OuycA5hLFx@ubunlion>
 <7dc9b4d2-413-3f65-1381-b164d810c3ee@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OeYwv3HN8BVedkYl"
Content-Disposition: inline
In-Reply-To: <7dc9b4d2-413-3f65-1381-b164d810c3ee@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OeYwv3HN8BVedkYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 31, 2022 at 01:05:32PM +0100, Julia Lawall wrote:
>
>
> I took a look, but it's pretty complex.  You could take the code and
> reorganize it so that it is more readable, and then take the definition of
> the ARRAY_SIZE macro, to better see what is going on.
>
> julia
>

Hello Greg, Julia,
I was able to successfully build the fbtft object file for arm architecture as
well. I used gcc 6.5.0 and 9.5.0 tool chains. It was successful using both. I
have attached the build log from my machine for your reference.

I am also looking at the .i file and rearrange the expanded macro to understand
it. However, since it is built successfully, I am not sure if that is truly the
problem area.

Should I resend the patch and check if it still errors the kernel build bot?
Anything else I can try?

Thank you,
./drv

--OeYwv3HN8BVedkYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbtft_build.log"

drv@qemulion:~/git/kernels/staging$ git status
On branch patches-11022022
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   drivers/staging/fbtft/fbtft.h

no changes added to commit (use "git add" and/or "git commit -a")
drv@qemulion:~/git/kernels/staging$ git diff
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 2c2b5f1c1df3..f2ed23123849 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -231,7 +231,7 @@ struct fbtft_par {
        bool polarity;
 };

-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
+#define NUMARGS(...)   ARRAY_SIZE(((int[]){ __VA_ARGS__ }))

 #define write_reg(par, ...)                                            \
        ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
drv@qemulion:~/git/kernels/staging$ make CROSS_COMPILE=/opt/gcc-9.5.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- --jobs=8 ARCH=arm drivers/staging/fbtft/fbtft-core.o
  CALL    scripts/checksyscalls.sh
  CC      drivers/staging/fbtft/fbtft-core.o
drv@qemulion:~/git/kernels/staging$ make CROSS_COMPILE=/opt/gcc-9.5.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- --jobs=8 ARCH=arm drivers/staging/fbtft/
  CALL    scripts/checksyscalls.sh
  CC      drivers/staging/fbtft/fbtft-sysfs.o
  CC      drivers/staging/fbtft/fbtft-bus.o
  CC      drivers/staging/fbtft/fbtft-io.o
  CC      drivers/staging/fbtft/fb_agm1264k-fl.o
  CC      drivers/staging/fbtft/fb_bd663474.o
  CC      drivers/staging/fbtft/fb_hx8340bn.o
  CC      drivers/staging/fbtft/fb_hx8347d.o
  CC      drivers/staging/fbtft/fb_hx8353d.o
  CC      drivers/staging/fbtft/fb_hx8357d.o
  CC      drivers/staging/fbtft/fb_ili9163.o
  CC      drivers/staging/fbtft/fb_ili9320.o
  CC      drivers/staging/fbtft/fb_ili9325.o
  CC      drivers/staging/fbtft/fb_ili9340.o
  CC      drivers/staging/fbtft/fb_ili9341.o
  CC      drivers/staging/fbtft/fb_ili9481.o
  CC      drivers/staging/fbtft/fb_ili9486.o
  CC      drivers/staging/fbtft/fb_pcd8544.o
  CC      drivers/staging/fbtft/fb_ra8875.o
  CC      drivers/staging/fbtft/fb_s6d02a1.o
  CC      drivers/staging/fbtft/fb_s6d1121.o
  CC      drivers/staging/fbtft/fb_seps525.o
  CC      drivers/staging/fbtft/fb_sh1106.o
  CC      drivers/staging/fbtft/fb_ssd1289.o
  CC      drivers/staging/fbtft/fb_ssd1305.o
  CC      drivers/staging/fbtft/fb_ssd1306.o
  CC      drivers/staging/fbtft/fb_ssd1325.o
  CC      drivers/staging/fbtft/fb_ssd1331.o
  CC      drivers/staging/fbtft/fb_ssd1351.o
  CC      drivers/staging/fbtft/fb_st7735r.o
  CC      drivers/staging/fbtft/fb_st7789v.o
  CC      drivers/staging/fbtft/fb_tinylcd.o
  CC      drivers/staging/fbtft/fb_tls8204.o
  CC      drivers/staging/fbtft/fb_uc1611.o
  CC      drivers/staging/fbtft/fb_uc1701.o
  CC      drivers/staging/fbtft/fb_upd161704.o
  AR      drivers/staging/fbtft/built-in.a
drv@qemulion:~/git/kernels/staging$


--OeYwv3HN8BVedkYl--


