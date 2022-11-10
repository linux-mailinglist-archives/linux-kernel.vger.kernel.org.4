Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9032623C33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiKJG5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKJG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:57:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674552F38F;
        Wed,  9 Nov 2022 22:57:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so904231wrq.3;
        Wed, 09 Nov 2022 22:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1O9vx/w0pSScJPYJU2hSXOoClhMo14F1MGXdWp+Ufg=;
        b=ih2hj2AwLw6uHnoVWJIxZvKqdEAjHM0jD7xTrnsEAwACZBNaBmpfcMk5js1HYZby6j
         lZ14H3xql7RMtd4Y631wpUfgRpewaFbcFGzKPVwWfKNW2ligyRCLwPQ0coycdb/HPLK5
         Aa1eGy6Pbd1viF+NxdMGsQyEO5mqdq94QY682+gg46t1yKKXWpO4OF40rayUs3SIG9KG
         BN6bsWIsNMEzq0E+OtfV1rOk0IizI2F1Dpa0xipPGxX4ZJeUp16zdkHN+WshRusac+TJ
         S4RoDuaavXzvW1osuQLAGkp00ifZsf31CoNtZIuefwBTNOVgXZexiRyt3fbOd97uwWYv
         bdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1O9vx/w0pSScJPYJU2hSXOoClhMo14F1MGXdWp+Ufg=;
        b=pD6Nv2uzd9O8Q6DHTF9PPrzb02A0Di6PrtVFtN2HDNk4XEr8rg+JmHc6D04in6fbOa
         YTUT8FsTfkHcLskSPMk0/oRH+7DC3NnRxO1+Jf4+z8rjIhE7DpCxla+om6h13Sqq/J/b
         PBVBNVN/4EZZFW6hSNqfSA8WybAKzAl4mej+Vq1XmGnmTLJ0bWWRsY2lf0l2bWRLBY5D
         MZBgyUlPoEyWVpD7KFW6zqP6avkA4h9uXA6LTvy+ESN1RyvqD/SQPV6pgN0PZDQ3CYNZ
         gw31oNh05wVnYinlKSIJGLdeDauEvvUzlAKjEfyVEdc1q1YHNtfBbN1gs7bWBkl4Splt
         0nWQ==
X-Gm-Message-State: ACrzQf0G/am4vk5Xm9J8yyMIZX7f/kpZXRPh/z2sIu/j2kPYYpwQFjYu
        ikrn6lUPpTyac4z7P5iLdEc=
X-Google-Smtp-Source: AMsMyM6YvildaZhGa/d4MYEc0dWoFhApR6w0TXgYEOeTCBEzNq0RU0eJrIdKmvqEDf29jjNFtqRVCQ==
X-Received: by 2002:a5d:618e:0:b0:22a:f546:3f68 with SMTP id j14-20020a5d618e000000b0022af5463f68mr995725wru.651.1668063428798;
        Wed, 09 Nov 2022 22:57:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c6f426467fsm4357994wmq.40.2022.11.09.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 22:57:08 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:57:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 01/28] media: sun6i-csi: Add bridge v4l2 subdev with
 port management
Message-ID: <202211100529.cG57XaEQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103163113.245462-2-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Kocialkowski/Allwinner-A31-A83T-MIPI-CSI-2-and-A31-ISP-CSI-Rework/20221104-003518
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20221103163113.245462-2-paul.kocialkowski%40bootlin.com
patch subject: [PATCH v7 01/28] media: sun6i-csi: Add bridge v4l2 subdev with port management
config: arc-randconfig-m041-20221107
compiler: arc-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c:86 sun6i_csi_bridge_s_stream() warn: missing error code 'ret'
drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c:279 sun6i_csi_bridge_notifier_bound() error: uninitialized symbol 'enabled'.

vim +/ret +86 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c

d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   62  static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   63  {
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   64  	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   65  	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   66  	struct media_pad *local_pad = &bridge->pads[SUN6I_CSI_BRIDGE_PAD_SINK];
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   67  	struct device *dev = csi_dev->dev;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   68  	struct v4l2_subdev *source_subdev;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   69  	struct media_pad *remote_pad;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   70  	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   71  	int ret = 0;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   72  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   73  	/* Source */
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   74  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   75  	remote_pad = media_pad_remote_pad_unique(local_pad);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   76  	if (IS_ERR(remote_pad)) {
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   77  		dev_err(dev,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   78  			"zero or more than a single source connected to the bridge\n");
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   79  		return PTR_ERR(remote_pad);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   80  	}
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   81  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   82  	source_subdev = media_entity_to_v4l2_subdev(remote_pad->entity);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   83  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   84  	if (!on) {
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   85  		v4l2_subdev_call(source_subdev, video, s_stream, 0);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  @86  		goto disable;

This is intentional, but it should just return 0;

d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   87  	}
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   88  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   89  	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   90  	if (ret && ret != -ENOIOCTLCMD)
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   91  		goto disable;

Do we really need to clean anything up?  Why not just:

	source_subdev = media_entity_to_v4l2_subdev(remote_pad->entity);

	return v4l2_subdev_call(source_subdev, video, s_stream, !!on);

d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   92  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   93  	return 0;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   94  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   95  disable:
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   96  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   97  	return ret;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   98  }
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03   99  

[ snip ]

d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  254  static int
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  255  sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  256  				struct v4l2_subdev *remote_subdev,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  257  				struct v4l2_async_subdev *async_subdev)
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  258  {
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  259  	struct sun6i_csi_device *csi_dev =
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  260  		container_of(notifier, struct sun6i_csi_device,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  261  			     bridge.notifier);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  262  	struct sun6i_csi_bridge_async_subdev *bridge_async_subdev =
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  263  		container_of(async_subdev, struct sun6i_csi_bridge_async_subdev,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  264  			     async_subdev);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  265  	struct sun6i_csi_bridge_source *source = bridge_async_subdev->source;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  266  	bool enabled;

This neesds to be "bool enabled = false;"

d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  267  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  268  	switch (source->endpoint.base.port) {
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  269  	case SUN6I_CSI_PORT_PARALLEL:
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  270  		enabled = true;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  271  		break;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  272  	default:
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  273  		break;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  274  	}
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  275  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  276  	source->subdev = remote_subdev;
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  277  
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  278  	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03 @279  				     remote_subdev, enabled);
d26de0b15ad9da7 Paul Kocialkowski 2022-11-03  280  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

