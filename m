Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4F6C384A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCUReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCUReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:34:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED293B21D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:34:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso16655847pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679420049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IrG3KM48uf+MHB5GR1cO4e1VeS+J78/a62kYmL36ANU=;
        b=K4DVKgfOWCxZd72duRcARmY4iQMSXm5ZWSkzr8lNPTk7T77UwXtLoGxmGRNWeR6xt8
         GzFpvPwyAzpbWiie5fZztP3cvSQnal1z0XlAMsWmmp749nufWyIbZT3Ux04VrqzIEz/d
         jIMZaFEjfTReR7HiTD/0jrTTgMOr37wb5HxjzVMm2WEfy5TgM6RoFacSEBt6LStgwoTL
         G33OK7aX135jWLGJZvuUChbv8p7X8RrsNsS7DcVeQV6F0bDIhy48wzfGpwWWkxL8fh/A
         HPDYPhhjkYZ/sZgDdw5z375yqpwbj3/UAkLJ9h8oFB16UF/RV1zHYSBw4C66dstRzXmX
         778Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrG3KM48uf+MHB5GR1cO4e1VeS+J78/a62kYmL36ANU=;
        b=cQWc8vePMWPDxke8BaLVmG0EA2XHu5HJpdZW5IoRanIbtavNOwWOZZOh+lro4Ez7pH
         9EV9ipLKjtDkjQBD+460FOu4AzSIfPt+ctaoqD+zYS8uCOV3Tv2IOW3z9NC/AsB3PfnF
         bwxYWcplH7ARCfuMIZ/DbTEt5r5gym5WhLgctuqpmKaGa0aNJ5dBOu5ecpRAcoID0MYo
         3qRiIGrSu4sO7LccH1JEunEnYvXI+jeKjGdLDfwm5Bx0WpYCSmgCF3cvB1cuYhs5Dzt7
         OInlk4HMmWjt9KqQiZI2w/GBnh/RGwFZJWhSF4IPgxvuj5UHz7SyqqhNXQr0sOqD0hDt
         x+rQ==
X-Gm-Message-State: AO0yUKVXcT3lUJBEz0PJ2IDkzjBwG5vdPSa3e6BvBxXqVBezuHU42XTg
        U7x0bLEX2hiI6vurZgeTS4TTH23TB1CXxqDBJ9UC7g==
X-Google-Smtp-Source: AK7set/Rbguy4U1vMp/XcgLVvSJz9g64QUx2VfHmUmUS8JmxKY1Hd8s5AQ5TaiBz+eu0XwLete7Gtl/PqR2P7FkZZ2Y=
X-Received: by 2002:a17:90a:7894:b0:23f:76a1:61fb with SMTP id
 x20-20020a17090a789400b0023f76a161fbmr205177pjk.6.1679420048847; Tue, 21 Mar
 2023 10:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-5-james.clark@arm.com>
In-Reply-To: <20230310160610.742382-5-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 17:33:56 +0000
Message-ID: <CAJ9a7VhG5KipjGF2X=sto8fGEsih9yHsyqKivWG-bwuickw1Bw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] coresight: Rename connection members to allow for
 input connections
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, 10 Mar 2023 at 16:06, James Clark <james.clark@arm.com> wrote:
>
> References to outport and child_port will be confusing when we use the
> same struct for inputs as well as outputs. Rename the members to refer
> to the position in terms of local and remote instead.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  | 70 +++++++++----------
>  .../hwtracing/coresight/coresight-platform.c  | 32 ++++-----
>  drivers/hwtracing/coresight/coresight-sysfs.c | 10 +--
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
>  include/linux/coresight.h                     | 23 +++---
>  5 files changed, 71 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 617be08883da..f457914e445e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -120,8 +120,8 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
>
>         for (i = 0; i < parent->pdata->nr_outconns; i++) {
>                 conn = &parent->pdata->out_conns[i];
> -               if (conn->child_dev == csdev)
> -                       return conn->child_port;
> +               if (conn->remote_dev == csdev)
> +                       return conn->remote_port;
>         }
>
>         dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
> @@ -138,8 +138,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>                 conn = &csdev->pdata->out_conns[i];
> -               if (conn->child_dev == child)
> -                       return conn->outport;
> +               if (conn->remote_dev == child)
> +                       return conn->port;
>         }
>
>         dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
> @@ -604,11 +604,11 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
>          * Recursively explore each port found on this element.
>          */
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -               struct coresight_device *child_dev;
> +               struct coresight_device *remote_dev;
>
> -               child_dev = csdev->pdata->out_conns[i].child_dev;
> -               if (child_dev)
> -                       sink = coresight_find_enabled_sink(child_dev);
> +               remote_dev = csdev->pdata->out_conns[i].remote_dev;
> +               if (remote_dev)
> +                       sink = coresight_find_enabled_sink(remote_dev);
>                 if (sink)
>                         return sink;
>         }
> @@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>                 struct coresight_device *child;
>
> -               child = csdev->pdata->out_conns[i].child_dev;
> +               child = csdev->pdata->out_conns[i].remote_dev;
>                 if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>                         if (!coresight_get_ref(child))
>                                 goto err;
> @@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>         for (i--; i >= 0; i--) {
>                 struct coresight_device *child;
>
> -               child = csdev->pdata->out_conns[i].child_dev;
> +               child = csdev->pdata->out_conns[i].remote_dev;
>                 if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>                         coresight_put_ref(child);
>         }
> @@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>                 struct coresight_device *child;
>
> -               child = csdev->pdata->out_conns[i].child_dev;
> +               child = csdev->pdata->out_conns[i].remote_dev;
>                 if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>                         coresight_put_ref(child);
>         }
> @@ -792,11 +792,11 @@ static int _coresight_build_path(struct coresight_device *csdev,
>
>         /* Not a sink - recursively explore each port found on this element */
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -               struct coresight_device *child_dev;
> +               struct coresight_device *remote_dev;
>
> -               child_dev = csdev->pdata->out_conns[i].child_dev;
> -               if (child_dev &&
> -                   _coresight_build_path(child_dev, sink, path) == 0) {
> +               remote_dev = csdev->pdata->out_conns[i].remote_dev;
> +               if (remote_dev &&
> +                   _coresight_build_path(remote_dev, sink, path) == 0) {
>                         found = true;
>                         break;
>                 }
> @@ -961,12 +961,12 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
>          * recursively explore each port found on this element.
>          */
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -               struct coresight_device *child_dev, *sink = NULL;
> +               struct coresight_device *remote_dev, *sink = NULL;
>                 int child_depth = curr_depth;
>
> -               child_dev = csdev->pdata->out_conns[i].child_dev;
> -               if (child_dev)
> -                       sink = coresight_find_sink(child_dev, &child_depth);
> +               remote_dev = csdev->pdata->out_conns[i].remote_dev;
> +               if (remote_dev)
> +                       sink = coresight_find_sink(remote_dev, &child_depth);
>
>                 if (sink)
>                         found_sink = coresight_select_best_sink(found_sink,
> @@ -1337,12 +1337,12 @@ static int coresight_orphan_match(struct device *dev, void *data)
>                 conn = &i_csdev->pdata->out_conns[i];
>
>                 /* Skip the port if FW doesn't describe it */
> -               if (!conn->child_fwnode)
> +               if (!conn->remote_fwnode)
>                         continue;
>                 /* We have found at least one orphan connection */
> -               if (conn->child_dev == NULL) {
> +               if (conn->remote_dev == NULL) {
>                         /* Does it match this newly added device? */
> -                       if (conn->child_fwnode == csdev->dev.fwnode) {
> +                       if (conn->remote_fwnode == csdev->dev.fwnode) {
>                                 ret = coresight_make_links(i_csdev,
>                                                            conn, csdev);
>                                 if (ret)
> @@ -1377,13 +1377,13 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>                 struct coresight_connection *conn = &csdev->pdata->out_conns[i];
>
> -               if (!conn->child_fwnode)
> +               if (!conn->remote_fwnode)
>                         continue;
> -               conn->child_dev =
> -                       coresight_find_csdev_by_fwnode(conn->child_fwnode);
> -               if (conn->child_dev && conn->child_dev->has_conns_grp) {
> +               conn->remote_dev =
> +                       coresight_find_csdev_by_fwnode(conn->remote_fwnode);
> +               if (conn->remote_dev && conn->remote_dev->has_conns_grp) {
>                         ret = coresight_make_links(csdev, conn,
> -                                                  conn->child_dev);
> +                                                  conn->remote_dev);
>                         if (ret)
>                                 break;
>                 } else {
> @@ -1414,10 +1414,10 @@ static int coresight_remove_match(struct device *dev, void *data)
>         for (i = 0; i < iterator->pdata->nr_outconns; i++) {
>                 conn = &iterator->pdata->out_conns[i];
>
> -               if (conn->child_dev == NULL || conn->child_fwnode == NULL)
> +               if (conn->remote_dev == NULL || conn->remote_fwnode == NULL)
>                         continue;
>
> -               if (csdev->dev.fwnode == conn->child_fwnode) {
> +               if (csdev->dev.fwnode == conn->remote_fwnode) {
>                         iterator->orphan = true;
>                         coresight_remove_links(iterator, conn);
>                         /*
> @@ -1425,8 +1425,8 @@ static int coresight_remove_match(struct device *dev, void *data)
>                          * device acquired in parsing the connections from
>                          * platform data.
>                          */
> -                       fwnode_handle_put(conn->child_fwnode);
> -                       conn->child_fwnode = NULL;
> +                       fwnode_handle_put(conn->remote_fwnode);
> +                       conn->remote_fwnode = NULL;
>                         /* No need to continue */
>                         break;
>                 }
> @@ -1552,15 +1552,15 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>
>         for (i = 0; i < pdata->nr_outconns; i++) {
>                 /* If we have made the links, remove them now */
> -               if (csdev && conns[i].child_dev)
> +               if (csdev && conns[i].remote_dev)
>                         coresight_remove_links(csdev, &conns[i]);
>                 /*
>                  * Drop the refcount and clear the handle as this device
>                  * is going away
>                  */
> -               if (conns[i].child_fwnode) {
> -                       fwnode_handle_put(conns[i].child_fwnode);
> -                       pdata->out_conns[i].child_fwnode = NULL;
> +               if (conns[i].remote_fwnode) {
> +                       fwnode_handle_put(conns[i].remote_fwnode);
> +                       pdata->out_conns[i].remote_fwnode = NULL;
>                 }
>         }
>         if (csdev)
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index ed865e0621a9..c77238cdf448 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -252,13 +252,13 @@ static int of_coresight_parse_endpoint(struct device *dev,
>                 }
>
>                 conn = &pdata->out_conns[endpoint.port];
> -               if (conn->child_fwnode) {
> +               if (conn->remote_fwnode) {
>                         dev_warn(dev, "Duplicate output port %d\n",
>                                  endpoint.port);
>                         ret = -EINVAL;
>                         break;
>                 }
> -               conn->outport = endpoint.port;
> +               conn->port = endpoint.port;
>                 /*
>                  * Hold the refcount to the target device. This could be
>                  * released via:
> @@ -267,8 +267,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
>                  * 2) While removing the target device via
>                  *    coresight_remove_match()
>                  */
> -               conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
> -               conn->child_port = rendpoint.port;
> +               conn->remote_fwnode = fwnode_handle_get(rdev_fwnode);
> +               conn->remote_port = rendpoint.port;
>                 /* Connection record updated */
>         } while (0);
>
> @@ -649,8 +649,8 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
>
>         dir = fields[3].integer.value;
>         if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> -               conn->outport = fields[0].integer.value;
> -               conn->child_port = fields[1].integer.value;
> +               conn->port = fields[0].integer.value;
> +               conn->remote_port = fields[1].integer.value;
>                 rdev = coresight_find_device_by_fwnode(&r_adev->fwnode);
>                 if (!rdev)
>                         return -EPROBE_DEFER;
> @@ -662,14 +662,14 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
>                  * 2) While removing the target device via
>                  *    coresight_remove_match().
>                  */
> -               conn->child_fwnode = fwnode_handle_get(&r_adev->fwnode);
> +               conn->remote_fwnode = fwnode_handle_get(&r_adev->fwnode);
>         } else if (dir == ACPI_CORESIGHT_LINK_SLAVE) {
>                 /*
>                  * We are only interested in the port number
>                  * for the input ports at this component.
> -                * Store the port number in child_port.
> +                * Store the port number in remote_port.
>                  */
> -               conn->child_port = fields[0].integer.value;
> +               conn->remote_port = fields[0].integer.value;
>         } else {
>                 /* Invalid direction */
>                 return -EINVAL;
> @@ -718,11 +718,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>                         return dir;
>
>                 if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> -                       if (ptr->outport >= pdata->nr_outconns)
> -                               pdata->nr_outconns = ptr->outport + 1;
> +                       if (ptr->port >= pdata->nr_outconns)
> +                               pdata->nr_outconns = ptr->port + 1;
>                         ptr++;
>                 } else {
> -                       WARN_ON(pdata->nr_inconns == ptr->child_port + 1);
> +                       WARN_ON(pdata->nr_inconns == ptr->remote_port + 1);
>                         /*
>                          * We do not track input port connections for a device.
>                          * However we need the highest port number described,
> @@ -730,8 +730,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>                          * record for an output connection. Hence, do not move
>                          * the ptr for input connections
>                          */
> -                       if (ptr->child_port >= pdata->nr_inconns)
> -                               pdata->nr_inconns = ptr->child_port + 1;
> +                       if (ptr->remote_port >= pdata->nr_inconns)
> +                               pdata->nr_inconns = ptr->remote_port + 1;
>                 }
>         }
>
> @@ -741,10 +741,10 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>
>         /* Copy the connection information to the final location */
>         for (i = 0; conns + i < ptr; i++) {
> -               int port = conns[i].outport;
> +               int port = conns[i].port;
>
>                 /* Duplicate output port */
> -               WARN_ON(pdata->out_conns[port].child_fwnode);
> +               WARN_ON(pdata->out_conns[port].remote_fwnode);
>                 pdata->out_conns[port] = conns[i];
>         }
>
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 34d2a2d31d00..3da9868d9237 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -150,11 +150,11 @@ int coresight_make_links(struct coresight_device *orig,
>
>         do {
>                 outs = devm_kasprintf(&orig->dev, GFP_KERNEL,
> -                                     "out:%d", conn->outport);
> +                                     "out:%d", conn->port);
>                 if (!outs)
>                         break;
>                 ins = devm_kasprintf(&target->dev, GFP_KERNEL,
> -                                    "in:%d", conn->child_port);
> +                                    "in:%d", conn->remote_port);
>                 if (!ins)
>                         break;
>                 link = devm_kzalloc(&orig->dev,
> @@ -178,7 +178,7 @@ int coresight_make_links(struct coresight_device *orig,
>                  * Install the device connection. This also indicates that
>                  * the links are operational on both ends.
>                  */
> -               conn->child_dev = target;
> +               conn->remote_dev = target;
>                 return 0;
>         } while (0);
>
> @@ -198,9 +198,9 @@ void coresight_remove_links(struct coresight_device *orig,
>
>         coresight_remove_sysfs_link(conn->link);
>
> -       devm_kfree(&conn->child_dev->dev, conn->link->target_name);
> +       devm_kfree(&conn->remote_dev->dev, conn->link->target_name);
>         devm_kfree(&orig->dev, conn->link->orig_name);
>         devm_kfree(&orig->dev, conn->link);
>         conn->link = NULL;
> -       conn->child_dev = NULL;
> +       conn->remote_dev = NULL;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 4711dfa7418c..223081dc3ad4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -782,7 +782,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
>                 return NULL;
>
>         for (i = 0; i < etr->pdata->nr_outconns; i++) {
> -               tmp = etr->pdata->out_conns[i].child_dev;
> +               tmp = etr->pdata->out_conns[i].remote_dev;
>                 if (tmp && coresight_is_catu_device(tmp))
>                         return tmp;
>         }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index cdf0d1def778..64bb5fc95afa 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -164,18 +164,23 @@ struct coresight_desc {
>
>  /**
>   * struct coresight_connection - representation of a single connection
> - * @outport:   a connection's output port number.
> - * @child_port:        remote component's port number @output is connected to.
> - * @chid_fwnode: remote component's fwnode handle.
> - * @child_dev: a @coresight_device representation of the component
> -               connected to @outport.
> + * @port:        this connection's local port number. For input
> + *              connections this is the in-port. For outputs it's the
> + *              out-port.
> + * @remote_port: remote component's port number @port is connected to.
> + *              For input connections this is the out-port number on
> + *              remote device. For output connections it's the in-port
> + *              on the remote device.
> + * @remote_fwnode: remote component's fwnode handle.
> + * @remote_dev:  a @coresight_device representation of the component
> + *              connected to @port.
>   * @link: Representation of the connection as a sysfs link.
>   */
>  struct coresight_connection {
> -       int outport;
> -       int child_port;
> -       struct fwnode_handle *child_fwnode;
> -       struct coresight_device *child_dev;
> +       int port;

perhaps consider naming this explicitly local_port?

> +       int remote_port;
> +       struct fwnode_handle *remote_fwnode;
> +       struct coresight_device *remote_dev;
>         struct coresight_sysfs_link *link;

and while we are at it this could be sysfs_link?

>  };
>
> --
> 2.34.1
>
Either way,

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
