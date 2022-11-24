Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489926376DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKXKyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:54:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE02179A8A;
        Thu, 24 Nov 2022 02:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 651306208B;
        Thu, 24 Nov 2022 10:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF8C433D6;
        Thu, 24 Nov 2022 10:53:57 +0000 (UTC)
Message-ID: <bce00af1-1a2a-e910-2a53-e5efff117b06@xs4all.nl>
Date:   Thu, 24 Nov 2022 11:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v3 0/4] Add Toshiba Visconti Video Input Interface driver
In-Reply-To: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

On 10/08/2022 15:28, Yuji Ishikawa wrote:
> This series is the Video Input Interface driver
> for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation,
> device driver, documentation and MAINTAINER files.
> 
> A visconti VIIF driver instance exposes
> 1 media control device file and 3 video device files
> for a VIIF hardware. 
> Detailed HW/SW are described in documentation directory.
> The VIIF hardware has CSI2 receiver,
> image signal processor and DMAC inside.
> The subdevice for image signal processor provides
> vendor specific V4L2 controls.
> 
> The device driver depends on two other drivers under development;
> clock framework driver and IOMMU driver.
> Corresponding features will be added later.

I'm not sure what the status is of this series. There were comments for patch 1,
and also note that patch 2 never made it to the linux-media mailinglist (too large,
it should be split up in smaller patches).

I'm marking it as 'Changes Requested' in patchwork, so please post a v4
and I will do my best to review it.

Also please ping me in the future to encourage me to review it. These are
big drivers and it takes a lot of time to review, so I have a tendency (wrong,
I know) keep postponing it. A ping helps me prioritize it.

Regards,

	Hans

> 
> Best regards,
> Yuji
> 
> Changelog v2:
> - Resend v1 because a patch exceeds size limit.
> 
> Changelog v3:
> - Add documentation to describe SW and HW
> - Adapted to media control framework
> - Introduced ISP subdevice, capture device
> - Remove private IOCTLs and add vendor specific V4L2 controls
> - Change function name avoiding camelcase and uppercase letters
> 
> [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> 
> Yuji Ishikawa (4):
>   dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
>     Input Interface bindings
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface
>     driver
>   documentation: media: add documentation for Toshiba Visconti Video
>     Input Interface driver
>   MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
> 
>  .../bindings/media/toshiba,visconti-viif.yaml |  103 +
>  .../driver-api/media/drivers/index.rst        |    1 +
>  .../media/drivers/visconti-viif.rst           |  455 +++
>  MAINTAINERS                                   |    3 +
>  drivers/media/platform/Kconfig                |    2 +
>  drivers/media/platform/Makefile               |    4 +
>  drivers/media/platform/visconti/Kconfig       |    9 +
>  drivers/media/platform/visconti/Makefile      |    9 +
>  drivers/media/platform/visconti/hwd_viif.c    | 1791 +++++++++++
>  drivers/media/platform/visconti/hwd_viif.h    |  701 +++++
>  .../media/platform/visconti/hwd_viif_csi2rx.c |  723 +++++
>  .../platform/visconti/hwd_viif_internal.h     |  348 ++
>  .../media/platform/visconti/hwd_viif_l1isp.c  | 2727 ++++++++++++++++
>  .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
>  drivers/media/platform/visconti/viif.c        |  479 +++
>  drivers/media/platform/visconti/viif.h        |  195 ++
>  .../media/platform/visconti/viif_capture.c    | 1215 +++++++
>  .../media/platform/visconti/viif_controls.c   | 1149 +++++++
>  drivers/media/platform/visconti/viif_isp.c    |  852 +++++
>  include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
>  20 files changed, 15292 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>  create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
>  create mode 100644 drivers/media/platform/visconti/Kconfig
>  create mode 100644 drivers/media/platform/visconti/Makefile
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
>  create mode 100644 drivers/media/platform/visconti/viif.c
>  create mode 100644 drivers/media/platform/visconti/viif.h
>  create mode 100644 drivers/media/platform/visconti/viif_capture.c
>  create mode 100644 drivers/media/platform/visconti/viif_controls.c
>  create mode 100644 drivers/media/platform/visconti/viif_isp.c
>  create mode 100644 include/uapi/linux/visconti_viif.h
> 

