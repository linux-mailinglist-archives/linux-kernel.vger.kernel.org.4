Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622F69FBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjBVTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:16:33 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6103C7AC;
        Wed, 22 Feb 2023 11:16:28 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id eg37so30893901edb.12;
        Wed, 22 Feb 2023 11:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8OMPbfkGzMwVKhewKnHSr7b96xdEdz9Fo9VPGEXyeo=;
        b=vCeYfBtAYzs+QOR8PV/n/CqR9UfkB/cTEbgnu086sU8W+hzSblAAPY2sfcPLdccoVs
         tM76j6b1g+a3nEy58Xtnhgwr5i0FVKMmfDV3I9jFMqKtQ3wYnsRB303oylN7zkwOeDYL
         UNRPpmh55zM91/TTtCn1dH7sv6hGXILCGlBKrtC7n2T4bEdcmEJVWAhiijcMzYXv5Stz
         avwEgODwqhKSrhIs9bgvAVoNchEyv1tuUcBn+xw2DfKESaO2gb0Jvh2Jy6KZU4uaPox2
         ipFovNVWqsf3lIMeXFVyPq3mQP9gYGJZBHG6QHVSE9+jEM76W/E9dg+FTuZiiAadq1xl
         8gXg==
X-Gm-Message-State: AO0yUKUMbsYfWQqF1mWpOZeZjqOMO3DTMt526PpW/1WT2R4Rcb/tCAgG
        t0lwFAm8OD1IE7mhA+8/QvQvOhl89CRna9vh8Bg=
X-Google-Smtp-Source: AK7set/gchzdfE8ybFVa6ylCxERNymV45YM1jh/wttS1RsxoDJxelP2V+sznycMRhPpYe/p+o1Tlbo1onYVzxpZypL4=
X-Received: by 2002:a17:906:a292:b0:8b1:28e5:a1bc with SMTP id
 i18-20020a170906a29200b008b128e5a1bcmr8079721ejz.5.1677093386861; Wed, 22 Feb
 2023 11:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20230217133344.79278-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230217133344.79278-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 20:16:15 +0100
Message-ID: <CAJZ5v0jV_Z04zWGuKoiXR4cMovVW8DRyfdYbcwUV30M12Z0shQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description of returned
 value in some functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 2:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some of the functions do not provide Return: section on absence of which
> kernel-doc complains. Besides that several functions return the fwnode
> handle with incremented reference count. Add a respective note to make sure
> that the caller decrements it when it's not needed anymore.
>
> While at it, unify the style of the Return: sections.
>
> Reported-by: Daniel Kaehn <kaehndan@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or please let me know if I need to pick it up.

> ---
>
> v2: rephrased the note, added tag, removed unrelated change
>     (all requested by Sakari)
>
>  drivers/base/property.c | 124 +++++++++++++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 083a95791d3b..3fc25e568598 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -37,6 +37,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
>   * @propname: Name of the property
>   *
>   * Check if property @propname is present in the device firmware description.
> + *
> + * Return: true if property @propname is present. Otherwise, returns false.
>   */
>  bool device_property_present(struct device *dev, const char *propname)
>  {
> @@ -48,6 +50,8 @@ EXPORT_SYMBOL_GPL(device_property_present);
>   * fwnode_property_present - check if a property of a firmware node is present
>   * @fwnode: Firmware node whose property to check
>   * @propname: Name of the property
> + *
> + * Return: true if property @propname is present. Otherwise, returns false.
>   */
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
>                              const char *propname)
> @@ -508,10 +512,10 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>   * Obtain a reference based on a named property in an fwnode, with
>   * integer arguments.
>   *
> - * Caller is responsible to call fwnode_handle_put() on the returned
> - * args->fwnode pointer.
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * @args->fwnode pointer.
>   *
> - * Returns: %0 on success
> + * Return: %0 on success
>   *         %-ENOENT when the index is out of bounds, the index has an empty
>   *                  reference or the property was not found
>   *         %-EINVAL on parse error
> @@ -547,8 +551,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
>   *
>   * @index can be used when the named reference holds a table of references.
>   *
> - * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
> - * call fwnode_handle_put() on the returned fwnode pointer.
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Return: a pointer to the reference fwnode, when found. Otherwise,
> + * returns an error pointer.
>   */
>  struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
>                                             const char *name,
> @@ -567,7 +574,7 @@ EXPORT_SYMBOL_GPL(fwnode_find_reference);
>   * fwnode_get_name - Return the name of a node
>   * @fwnode: The firmware node
>   *
> - * Returns a pointer to the node name.
> + * Return: a pointer to the node name, or %NULL.
>   */
>  const char *fwnode_get_name(const struct fwnode_handle *fwnode)
>  {
> @@ -579,7 +586,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_name);
>   * fwnode_get_name_prefix - Return the prefix of node for printing purposes
>   * @fwnode: The firmware node
>   *
> - * Returns the prefix of a node, intended to be printed right before the node.
> + * Return: the prefix of a node, intended to be printed right before the node.
>   * The prefix works also as a separator between the nodes.
>   */
>  const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> @@ -591,7 +598,10 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
>   *
> - * Return parent firmware node of the given node if possible or %NULL if no
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Return: parent firmware node of the given node if possible or %NULL if no
>   * parent was available.
>   */
>  struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> @@ -608,8 +618,12 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
>   * on the passed node, making it suitable for iterating through a
>   * node's parents.
>   *
> - * Returns a node pointer with refcount incremented, use
> - * fwnode_handle_put() on it when done.
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @fwnode
> + * unconditionally.
> + *
> + * Return: parent firmware node of the given node if possible or %NULL if no
> + * parent was available.
>   */
>  struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>  {
> @@ -629,8 +643,10 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>   * firmware node that has a corresponding struct device and returns that struct
>   * device.
>   *
> - * The caller of this function is expected to call put_device() on the returned
> - * device when they are done.
> + * The caller is responsible for calling put_device() on the returned device
> + * pointer.
> + *
> + * Return: a pointer to the device of the @fwnode's closest ancestor.
>   */
>  struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>  {
> @@ -651,7 +667,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>   * fwnode_count_parents - Return the number of parents a node has
>   * @fwnode: The node the parents of which are to be counted
>   *
> - * Returns the number of parents a node has.
> + * Return: the number of parents a node has.
>   */
>  unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
>  {
> @@ -670,12 +686,12 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
>   * @fwnode: The node the parent of which is requested
>   * @depth: Distance of the parent from the node
>   *
> - * Returns the nth parent of a node. If there is no parent at the requested
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Return: the nth parent of a node. If there is no parent at the requested
>   * @depth, %NULL is returned. If @depth is 0, the functionality is equivalent to
>   * fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent() and so on.
> - *
> - * The caller is responsible for calling fwnode_handle_put() for the returned
> - * node.
>   */
>  struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
>                                             unsigned int depth)
> @@ -700,7 +716,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
>   *
>   * A node is considered an ancestor of itself too.
>   *
> - * Returns true if @ancestor is an ancestor of @child. Otherwise, returns false.
> + * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
>   */
>  bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
>  {
> @@ -725,6 +741,10 @@ bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle
>   * fwnode_get_next_child_node - Return the next child node handle for a node
>   * @fwnode: Firmware node to find the next child node for.
>   * @child: Handle to one of the node's child nodes or a %NULL handle.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @child
> + * unconditionally.
>   */
>  struct fwnode_handle *
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
> @@ -735,10 +755,13 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>
>  /**
> - * fwnode_get_next_available_child_node - Return the next
> - * available child node handle for a node
> + * fwnode_get_next_available_child_node - Return the next available child node handle for a node
>   * @fwnode: Firmware node to find the next child node for.
>   * @child: Handle to one of the node's child nodes or a %NULL handle.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @child
> + * unconditionally.
>   */
>  struct fwnode_handle *
>  fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
> @@ -762,7 +785,11 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
>  /**
>   * device_get_next_child_node - Return the next child node handle for a device
>   * @dev: Device to find the next child node for.
> - * @child: Handle to one of the device's child nodes or a null handle.
> + * @child: Handle to one of the device's child nodes or a %NULL handle.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @child
> + * unconditionally.
>   */
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>                                                  struct fwnode_handle *child)
> @@ -787,6 +814,9 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
>   * fwnode_get_named_child_node - Return first matching named child node handle
>   * @fwnode: Firmware node to find the named child node for.
>   * @childname: String to match child node name against.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
>   */
>  struct fwnode_handle *
>  fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> @@ -800,6 +830,9 @@ EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
>   * device_get_named_child_node - Return first matching named child node handle
>   * @dev: Device to find the named child node for.
>   * @childname: String to match child node name against.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
>   */
>  struct fwnode_handle *device_get_named_child_node(const struct device *dev,
>                                                   const char *childname)
> @@ -812,7 +845,10 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
>   * fwnode_handle_get - Obtain a reference to a device node
>   * @fwnode: Pointer to the device node to obtain the reference to.
>   *
> - * Returns the fwnode handle.
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Return: the fwnode handle.
>   */
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
>  {
> @@ -841,6 +877,8 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
>   * fwnode_device_is_available - check if a device is available for use
>   * @fwnode: Pointer to the fwnode of the device.
>   *
> + * Return: true if device is available for use. Otherwise, returns false.
> + *
>   * For fwnode node types that don't implement the .device_is_available()
>   * operation, this function returns true.
>   */
> @@ -859,6 +897,8 @@ EXPORT_SYMBOL_GPL(fwnode_device_is_available);
>  /**
>   * device_get_child_node_count - return the number of child nodes for device
>   * @dev: Device to cound the child nodes for
> + *
> + * Return: the number of child nodes for a given device.
>   */
>  unsigned int device_get_child_node_count(const struct device *dev)
>  {
> @@ -934,7 +974,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
>   * @fwnode:    Pointer to the firmware node
>   * @index:     Index of the IO range
>   *
> - * Returns a pointer to the mapped memory.
> + * Return: a pointer to the mapped memory.
>   */
>  void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
>  {
> @@ -947,8 +987,8 @@ EXPORT_SYMBOL(fwnode_iomap);
>   * @fwnode:    Pointer to the firmware node
>   * @index:     Zero-based index of the IRQ
>   *
> - * Returns Linux IRQ number on success. Other values are determined
> - * accordingly to acpi_/of_ irq_get() operation.
> + * Return: Linux IRQ number on success. Other values are determined
> + * according to acpi_irq_get() or of_irq_get() operation.
>   */
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
>  {
> @@ -967,8 +1007,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
>   * number of the IRQ resource corresponding to the index of the matched
>   * string.
>   *
> - * Return:
> - * Linux IRQ number on success, or negative errno otherwise.
> + * Return: Linux IRQ number on success, or negative errno otherwise.
>   */
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
>  {
> @@ -990,7 +1029,11 @@ EXPORT_SYMBOL(fwnode_irq_get_byname);
>   * @fwnode: Pointer to the parent firmware node
>   * @prev: Previous endpoint node or %NULL to get the first
>   *
> - * Returns an endpoint firmware node pointer or %NULL if no more endpoints
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer. Note that this function also puts a reference to @prev
> + * unconditionally.
> + *
> + * Return: an endpoint firmware node pointer or %NULL if no more endpoints
>   * are available.
>   */
>  struct fwnode_handle *
> @@ -1030,6 +1073,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>   * fwnode_graph_get_port_parent - Return the device fwnode of a port endpoint
>   * @endpoint: Endpoint firmware node of the port
>   *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
>   * Return: the firmware node of the device the @endpoint belongs to.
>   */
>  struct fwnode_handle *
> @@ -1051,6 +1097,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_port_parent);
>   * @fwnode: Endpoint firmware node pointing to the remote endpoint
>   *
>   * Extracts firmware node of a remote device the @fwnode points to.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
>   */
>  struct fwnode_handle *
>  fwnode_graph_get_remote_port_parent(const struct fwnode_handle *fwnode)
> @@ -1071,6 +1120,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
>   * @fwnode: Endpoint firmware node pointing to the remote endpoint
>   *
>   * Extracts firmware node of a remote port the @fwnode points to.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
>   */
>  struct fwnode_handle *
>  fwnode_graph_get_remote_port(const struct fwnode_handle *fwnode)
> @@ -1084,6 +1136,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
>   * @fwnode: Endpoint firmware node pointing to the remote endpoint
>   *
>   * Extracts firmware node of a remote endpoint the @fwnode points to.
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
>   */
>  struct fwnode_handle *
>  fwnode_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
> @@ -1111,8 +1166,11 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
>   * @endpoint: identifier of the endpoint node under the port node
>   * @flags: fwnode lookup flags
>   *
> - * Return the fwnode handle of the local endpoint corresponding the port and
> - * endpoint IDs or NULL if not found.
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Return: the fwnode handle of the local endpoint corresponding the port and
> + * endpoint IDs or %NULL if not found.
>   *
>   * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
>   * has not been found, look for the closest endpoint ID greater than the
> @@ -1120,9 +1178,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
>   *
>   * Does not return endpoints that belong to disabled devices or endpoints that
>   * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
> - *
> - * The returned endpoint needs to be released by calling fwnode_handle_put() on
> - * it when it is not needed any more.
>   */
>  struct fwnode_handle *
>  fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
> @@ -1328,7 +1383,8 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
>   * @fwnode and other device nodes. @match will be used to convert the
>   * connection description to data the caller is expecting to be returned
>   * through the @matches array.
> - * If @matches is NULL @matches_len is ignored and the total number of resolved
> + *
> + * If @matches is %NULL @matches_len is ignored and the total number of resolved
>   * matches is returned.
>   *
>   * Return: Number of matches resolved, or negative errno.
> --
> 2.39.1
>
