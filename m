Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8022E7439AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjF3KhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjF3KgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:36:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11EC4239
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121329; x=1719657329;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=Rwl8bqN+21VTh+5p6WqwK9MwtCNb9m3eC9zs925Wdiw=;
  b=R9j5jOAX35dVb2GMAWlUD0snAFdd7unmMlSUHp4ZHSFFk8tgivxWHk83
   2AMEi+Y4vXMu7W9XN1US0TTLD8rbGaWDtLysfspJSZHzB7R6i0S/a86Zi
   eDMJiEWbmo3ppJC7FtILH8+1tZiZFUKG2eQTtROYM3ioaqP3ykfD2i1Tu
   klsWR8/7cNoEeC6WAmYdnf4Wwp/yS/LRme54gzejoPGy067XVXoGzlNMU
   3foN7F072EFJos7qTANO/gXlIZoZAFVdqxnq2kHWk+ztFfEApol4dY7od
   ux1bCw73FwweVsTTLPHx7jWlP+XW4x1EKLvgQe9wU3Gy5W2MfzetZSzI1
   A==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="235292498"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:35:23 +0800
IronPort-SDR: BpefDHdM/nsXOUiwkn6l+qj5qE2OIlFf4Cj8Sdmwij44PpJ7crpHoKYGae3MKeIHk4McYWK1+a
 nSCyzvd4F9qAn438GO3f0jGbPLmoRpM90LwHvUo2w05OnKXq2mHHw5q1t0Wtb1LHzBkcokd1Vc
 X6rVabXGyKbHqTGBIpcwK3OQSNJnqHk1uPUArnCqRbK32XUTYRNU8uxDBPOvx6bjJWekN9DtSy
 HdtmEUiTk7rGopJHWlvjwjahgGVpFkVzBcbiZh3JrTp44q4RvmAeu9MVFKIhg30ix7FUHYhFDn
 xnY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:49:38 -0700
IronPort-SDR: NxPdHsNao8mT2n3or7xO50YqZ5vU9IReGIJEUHTv6tHaezpJHYbyCLdOnfFbrSKndzQ0FEenBf
 qcjnsPtNOQD5FUxMktAPikPfXchRe6UZIgFZKB7Bd2/FK/vHJ0xl4BWb0iSAVribiqvBiBv63F
 gWdCwP8AltKC63DU4msGxov93Dk4GBu6Gr1OO92Z9kqlQrVw3BhUX35PBopDBEZ9Fh+YmB6rFG
 HB9kgRzoy134kRYe8nzwZCVgfJu2ArWysFH92NSiBOHKChfniR6TsvRoglvUhSwRWVeBNvcd+F
 Z3Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:35:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4QssCZ59Xpz1RtVy
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:35:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121307; x=1690713308; bh=Rwl8b
        qN+21VTh+5p6WqwK9MwtCNb9m3eC9zs925Wdiw=; b=AVcq8nk3xpbH9CJUOEtpY
        Vz9m69brovLX9N6Nc0T4Addtc7podn7j54MVEKRWohCH2JC1kCv7fVdXRAnTf385
        Ou1+YcdrjOAM17ng161TviXUNRjaXHWdLDPG2R4iPbnzRxj+BZZHsePXbCx48UR5
        8+5AA9NZ9n5t+5e9QCvmTJ2DtKJ1plwTSLgllHX2mOGwzJZgRg4OriAcDaGjRszN
        9j+nsleestCxLi8dJylXRfQPwl4UzGS6LdCIq/s99ck4ywWTxMIiFAvDarh7u5TP
        ZdcAqpMV1JbP9Wy3E+cERXUFu8aMCrYETPQZ37k8VtQr8dwpSAr7z7GnSaZl9x32
        w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gf05g413s67z for <linux-kernel@vger.kernel.org>;
        Fri, 30 Jun 2023 03:35:07 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4QssCH1gGCz1RtVm;
        Fri, 30 Jun 2023 03:35:07 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:05:07 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans.Holmberg@wdc.com, Aravind.Ramesh@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@infradead.org,
        Matias.Bjorling@wdc.com, a.hindborg@samsung.com,
        linux-kernel@vger.kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, minwoo.im.dev@gmail.com, ming.lei@redhat.com
Subject: Re: [PATCH v4 4/4] ublk: add zone append
In-Reply-To: <39701CAF-7AE2-4C83-A4DD-929A0A4FB8F0@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
 <39701CAF-7AE2-4C83-A4DD-929A0A4FB8F0@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <76a4ad50bb79acfe89e7d5d3a354d061@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andreas Hindborg <a.hindborg@samsung.com 
> <mailto:a.hindborg@samsung.com>>
> 
> 
> Add zone append feature to ublk. This feature uses the `addr` field of 
> `struct

checkpatch.pl warns on the keeping the line within 75 characters.
WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)

> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
> feature (UBLK_F_USER_COPY) for zone append to be available. Without 
> this
> feature, ublk will fail zone append requests.
> 
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com 
> <mailto:ming.lei@redhat.com>>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> ---
> drivers/block/ublk_drv-zoned.c | 11 +++++++++
> drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++++++----
> drivers/block/ublk_drv.h | 1 +
> include/uapi/linux/ublk_cmd.h | 3 ++-
> 4 files changed, 52 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/drivers/block/ublk_drv-zoned.c 
> b/drivers/block/ublk_drv-zoned.c
> index ea86bf4b3681..007e8fc7ff25 100644
> --- a/drivers/block/ublk_drv-zoned.c
> +++ b/drivers/block/ublk_drv-zoned.c
> @@ -16,6 +16,16 @@ void ublk_set_nr_zones(struct ublk_device *ub)
> ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
> }
> 
> 
> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> + const struct ublk_param_zoned *p = &ub->params.zoned;
> +
> + if (! p->max_zone_append_sectors)

checkpatch.pl errors out here
ERROR: space prohibited after that '!' (ctx:BxW)
if (!p->max_zone_append_sectors)

> + return -EINVAL;
> +
> + return 0;
> +}
> +
> void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> {
> const struct ublk_param_zoned *p = &ub->params.zoned;
> @@ -23,6 +33,7 @@ void ublk_dev_param_zoned_apply(struct ublk_device 
> *ub)
> if (ub->dev_info.flags & UBLK_F_ZONED) {
> disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> + blk_queue_max_zone_append_sectors(ub->ub_disk->queue,
> p->max_zone_append_sectors);
> }
> }
> 
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 88fa39853c61..6a949669b47e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -107,6 +107,11 @@ struct ublk_uring_cmd_pdu {
> */
> #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> 
> 
> +/*
> + * Set when IO is Zone Append
> + */
> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
> +
> struct ublk_io {
> /* userspace buffer address from io cmd */
> __u64 addr;
> @@ -230,6 +235,8 @@ static void ublk_dev_param_discard_apply(struct
> ublk_device *ub)
> 
> 
> static int ublk_validate_params(const struct ublk_device *ub)
> {
> + int ret = 0;
> +
> /* basic param is the only one which must be set */
> if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
> const struct ublk_param_basic *p = &ub->params.basic;
> @@ -260,6 +267,13 @@ static int ublk_validate_params(const struct
> ublk_device *ub)
> if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
> return -EINVAL;
> 
> 
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> + (ub->params.types & UBLK_PARAM_TYPE_ZONED)) {
> + ret = ublk_dev_param_zoned_validate(ub);
> + if (ret)
> + return ret;
> + }
> +
> return 0;
> }
> 
> 
> @@ -690,6 +704,11 @@ static blk_status_t ublk_setup_iod(struct
> ublk_queue *ubq, struct request *req)
> return BLK_STS_IOERR;
> }
> case REQ_OP_ZONE_APPEND:
> + if (!(ubq->dev->dev_info.flags & UBLK_F_USER_COPY))
> + return BLK_STS_IOERR;
> + ublk_op = UBLK_IO_OP_ZONE_APPEND;
> + io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
> + break;
> case REQ_OP_ZONE_RESET_ALL:
> case REQ_OP_DRV_OUT:
> /* We do not support zone append or reset_all yet */
> @@ -1112,6 +1131,12 @@ static void ublk_commit_completion(struct
> ublk_device *ub,
> /* find the io request and complete */
> req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> 
> 
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> + if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
> + req->__sector = ub_cmd->addr;
> + io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
> + }
> +
> if (req && likely(!blk_should_fake_timeout(req->q)))
> ublk_put_req_ref(ubq, req);
> }
> @@ -1411,7 +1436,8 @@ static int __ublk_ch_uring_cmd(struct 
> io_uring_cmd *cmd,
> ^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
> goto out;
> 
> 
> - if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> + if (ublk_support_user_copy(ubq) &&
> + !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
> ret = -EINVAL;
> goto out;
> }
> @@ -1534,11 +1560,14 @@ static inline bool ublk_check_ubuf_dir(const
> struct request *req,
> int ubuf_dir)
> {
> /* copy ubuf to request pages */
> - if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
> + if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) &&
> + ubuf_dir == ITER_SOURCE)
> return true;
> 
> 
> /* copy request pages to ubuf */
> - if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
> + if ((req_op(req) == REQ_OP_WRITE ||
> + req_op(req) == REQ_OP_ZONE_APPEND) &&
> + ubuf_dir == ITER_DEST)
> return true;
> 
> 
> return false;
> @@ -1867,6 +1896,12 @@ static int ublk_ctrl_start_dev(struct
> ublk_device *ub, struct io_uring_cmd *cmd)
> ub->dev_info.ublksrv_pid = ublksrv_pid;
> ub->ub_disk = disk;
> 
> 
> + ub->dev_info.state = UBLK_S_DEV_LIVE;
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> + ub->dev_info.flags & UBLK_F_ZONED) {
> + disk_set_zoned(disk, BLK_ZONED_HM);
> + }
> +
> ret = ublk_apply_params(ub);
> if (ret)
> goto out_put_disk;
> @@ -1877,7 +1912,6 @@ static int ublk_ctrl_start_dev(struct
> ublk_device *ub, struct io_uring_cmd *cmd)
> 
> 
> if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> ub->dev_info.flags & UBLK_F_ZONED) {
> - disk_set_zoned(disk, BLK_ZONED_HM);
> blk_queue_required_elevator_features(disk->queue, 
> ELEVATOR_F_ZBD_SEQ_WRITE);
> ret = ublk_revalidate_disk_zones(disk);
> if (ret)
> @@ -1885,7 +1919,6 @@ static int ublk_ctrl_start_dev(struct
> ublk_device *ub, struct io_uring_cmd *cmd)
> }
> 
> 
> get_device(&ub->cdev_dev);
> - ub->dev_info.state = UBLK_S_DEV_LIVE;
> ret = add_disk(disk);
> if (ret) {
> /*
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> index 7242430fd6b9..f55e1c25531d 100644
> --- a/drivers/block/ublk_drv.h
> +++ b/drivers/block/ublk_drv.h
> @@ -56,6 +56,7 @@ struct ublk_rq_data {
> };
> 
> 
> void ublk_set_nr_zones(struct ublk_device *ub);
> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
> void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> int ublk_revalidate_disk_zones(struct gendisk *disk);
> 
> 
> diff --git a/include/uapi/linux/ublk_cmd.h 
> b/include/uapi/linux/ublk_cmd.h
> index 436525afffe8..4b6ad0b28598 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -351,7 +351,8 @@ struct ublk_param_devt {
> struct ublk_param_zoned {
> __u32 max_open_zones;
> __u32 max_active_zones;
> - __u8 reserved[24];
> + __u32 max_zone_append_sectors;
> + __u8 reserved[20];
> };
> 
> 
> struct ublk_params {

Regards,
Aravind
