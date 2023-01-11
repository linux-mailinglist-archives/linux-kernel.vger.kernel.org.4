Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3506652B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjAKET5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjAKETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:19:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746313CC8;
        Tue, 10 Jan 2023 20:19:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8642929wma.1;
        Tue, 10 Jan 2023 20:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUMPKuhG+8Z6R1irpovw2uiZug8L2MoeWPZFn367qSI=;
        b=EaF6u+VcLozIFsgA68VCjOaRTNBQyfHtzVB/YvrScNR1GlpHprKGOXvcE/jd3IHxjA
         pYhKH9KDYetrf6sutCDdy/vM/R3q0W+rysDIZh+TVAm3c/0L/Jniwetn01plz0BWYFcJ
         IAIsETd6h8uU364qrKdg5+XUgwTg8nGEtrKIZIBNgPYoHsE4f+fyNVHcbH7GhTJDWOHg
         fvn3tg65o4WFxbyBToXreBT2LXeeysnFfDWqJNAZVzBs/KcmbLkqzHh5Kh6mqzqtUCgQ
         Px4r9hgeL/78CdWX//g/vL8cdLmejlK9yYVoHo6Ii6nA/g0Plox24PP34kYVGl/vkguX
         LRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUMPKuhG+8Z6R1irpovw2uiZug8L2MoeWPZFn367qSI=;
        b=rRjn6JZTlXqE1s6cuu4cBcjNFYopOQk2M9oBJBEJVx6yxvlDlFjboorg0DLgEhqG2y
         KcJdnBnz9mzwrEHMIvgjZUltASPzEWpuEkMmFv/46vKhkZZ4KrDHZjDkeNv3u4RRnlTy
         4lm51QQCWX5QPt7Zf4uw2hxycf+jFy0y2u5SPRqoO6eN8ZhgHKsnFWxu7Evp2hTHSKFi
         EgFkkmxiHGLe2wuuwWb4hrv3U9O0BAmP+nFLpvthhEWssDbrq/BGCn8c6MtcrML5UElM
         HscKlMntZDX/UyTz5xKNe7UncvM7vUtbzyIiu0Up3BNVUGEBXDWGhPoDBRN9iwSlot8U
         UVRA==
X-Gm-Message-State: AFqh2krm4/g7K5EJrr3Qm0Q0D6Qir8tpUtwOrNiBL0Hqqt/WR0qf8sZc
        ZMGwg1Xz6bDqLzp/ct/aRVI=
X-Google-Smtp-Source: AMrXdXsO4ilNvoM7fTh8urm1u9sF0qlhvkLU20CpHFdmH0XT8MYJ7kkIk5u2fON05SS8kG9RfyOtig==
X-Received: by 2002:a05:600c:1d18:b0:3d9:73fe:9744 with SMTP id l24-20020a05600c1d1800b003d973fe9744mr42444071wms.26.1673410785748;
        Tue, 10 Jan 2023 20:19:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm14833820wrs.0.2023.01.10.20.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 20:19:45 -0800 (PST)
Date:   Wed, 11 Jan 2023 07:19:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] media: uvc: Ignore empty TS packets
Message-ID: <202301110645.Dm6n60lb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v4-1-a8ddc1358a29@chromium.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/media-uvc-Ignore-empty-TS-packets/20230109-180318
base:   73d6709376914f577a61bb29e596fa93ec66598c
patch link:    https://lore.kernel.org/r/20220920-resend-hwtimestamp-v4-1-a8ddc1358a29%40chromium.org
patch subject: [PATCH v4 1/5] media: uvc: Ignore empty TS packets
config: arc-randconfig-m031-20230108
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/usb/uvc/uvc_video.c:538 uvc_video_clock_decode() error: we previously assumed 'buf' could be null (see line 514)

vim +/buf +538 drivers/media/usb/uvc/uvc_video.c

66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  469  static void
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  470  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
2c6b222cee2d68e drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2018-01-16  471  		       const u8 *data, int len)
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  472  {
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  473  	struct uvc_clock_sample *sample;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  474  	unsigned int header_size;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  475  	bool has_pts = false;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  476  	bool has_scr = false;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  477  	unsigned long flags;
828ee8c71950155 drivers/media/usb/uvc/uvc_video.c   Arnd Bergmann    2017-11-27  478  	ktime_t time;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  479  	u16 host_sof;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  480  	u16 dev_sof;
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  481  	u32 dev_stc;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  482  
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  483  	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  484  	case UVC_STREAM_PTS | UVC_STREAM_SCR:
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  485  		header_size = 12;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  486  		has_pts = true;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  487  		has_scr = true;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  488  		break;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  489  	case UVC_STREAM_PTS:
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  490  		header_size = 6;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  491  		has_pts = true;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  492  		break;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  493  	case UVC_STREAM_SCR:
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  494  		header_size = 8;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  495  		has_scr = true;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  496  		break;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  497  	default:
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  498  		header_size = 2;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  499  		break;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  500  	}
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  501  
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  502  	/* Check for invalid headers. */
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  503  	if (len < header_size)
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  504  		return;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  505  
699b9a86a3f03ad drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2022-06-08  506  	/*
699b9a86a3f03ad drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2022-06-08  507  	 * Extract the timestamps:
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  508  	 *
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  509  	 * - store the frame PTS in the buffer structure
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  510  	 * - if the SCR field is present, retrieve the host SOF counter and
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  511  	 *   kernel timestamps and store them with the SCR STC and SOF fields
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  512  	 *   in the ring buffer
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  513  	 */
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24 @514  	if (has_pts && buf != NULL)
                                                                                                       ^^^^^^^^^^^
This code checks for NULL.

66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  515  		buf->pts = get_unaligned_le32(&data[2]);
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  516  
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  517  	if (!has_scr)
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  518  		return;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  519  
699b9a86a3f03ad drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2022-06-08  520  	/*
699b9a86a3f03ad drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2022-06-08  521  	 * To limit the amount of data, drop SCRs with an SOF identical to the
a919bd4d768164c drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-04  522  	 * previous one. This filtering is also needed to support UVC 1.5, where
a919bd4d768164c drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-04  523  	 * all the data packets of the same frame contains the same SOF. In that
a919bd4d768164c drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-04  524  	 * case only the first one will match the host_sof.
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  525  	 */
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  526  	dev_sof = get_unaligned_le16(&data[header_size - 2]);
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  527  	if (dev_sof == stream->clock.last_sof)
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  528  		return;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  529  
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  530  	dev_stc = get_unaligned_le32(&data[header_size - 6]);
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  531  
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  532  	/*
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  533  	 * Some devices make a borderline interpretation of the UVC 1.5 standard
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  534  	 * and sends packets with no data contain undefined timestamps. Ignore
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  535  	 * such packages to avoid interfering with the clock interpolation
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  536  	 * algorithm.
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  537  	 */
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09 @538  	if (buf->bytesused == 0 && len == header_size &&
                                                                                            ^^^^^^^^^^^^^^
Unchecked dereference

febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  539  	    dev_stc == 0 && dev_sof == 0)
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  540  		return;
febd4163e286059 drivers/media/usb/uvc/uvc_video.c   Ricardo Ribalda  2023-01-09  541  
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  542  	stream->clock.last_sof = dev_sof;
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  543  
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  544  	host_sof = usb_get_current_frame_number(stream->dev->udev);
828ee8c71950155 drivers/media/usb/uvc/uvc_video.c   Arnd Bergmann    2017-11-27  545  	time = uvc_video_get_time();
66847ef013cc4ed drivers/media/video/uvc/uvc_video.c Laurent Pinchart 2011-09-24  546  
699b9a86a3f03ad drivers/media/usb/uvc/uvc_video.c   Laurent Pinchart 2022-06-08  547  	/*

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

