Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5B74D369
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjGJK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjGJK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:28:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA8CE;
        Mon, 10 Jul 2023 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984883; x=1720520883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IvTGun5BNpAUAhdxyhVIqnBaI5rXxgfJtArQMk9AwVY=;
  b=S0Vc9zTidRkT9cqSJ/Qjn1n2dGcmsLCWDM+vM/ydsGFC4MyP1+WQ5AdR
   s/RAs/5SY1vVl7xYJ/WAiy01YM6WLX2C6TW4gCl5hFr345Qwjv5y1fqzQ
   2frqXJ2q5jPbTAkbQDxYolhPr8q5XdVUnUJwpcP+JD0ylvZLMMHgN6/Oy
   Bkk0G3XR8W2ovT6DnzQhyq7ooiPyIq6fe7vhRc/hZOZpa9ozQGpnuiHNr
   BHvnrgTb09jAvDIjCpIWVXs3AnhYpe0GbLw7jWQvSW9FZ2jvFY2BwhSP7
   Nr+ORJgqimRonCTThIB309XDvgdGekaxUrNYbyRqVko2weKkG3fkywwUc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364345489"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364345489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865297557"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865297557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 03:27:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B2EE69A; Mon, 10 Jul 2023 13:27:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedTS.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 7/8] spi: Fix spelling typos and acronyms capitalization
Date:   Mon, 10 Jul 2023 13:27:50 +0300
Message-Id: <20230710102751.83314-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix
  - spelling typos
  - capitalization of acronyms
in the comments.

While at it, fix the multi-line comment style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 137 ++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 62 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8e7fc0f21714..e9fb96016dc1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -50,7 +50,7 @@ extern struct bus_type spi_bus_type;
 
 /**
  * struct spi_statistics - statistics for spi transfers
- * @syncp:         seqcount to protect members in this struct for per-cpu udate
+ * @syncp:         seqcount to protect members in this struct for per-cpu update
  *                 on 32-bit systems
  *
  * @messages:      number of spi-messages handled
@@ -69,7 +69,7 @@ extern struct bus_type spi_bus_type;
  * @bytes_rx:      number of bytes received from device
  *
  * @transfer_bytes_histo:
- *                 transfer bytes histogramm
+ *                 transfer bytes histogram
  *
  * @transfers_split_maxsize:
  *                 number of transfers that have been split because of
@@ -170,7 +170,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	the device will bind to the named driver and only the named driver.
  *	Do not set directly, because core frees it; use driver_set_override() to
  *	set or clear it.
- * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
+ * @cs_gpiod: GPIO descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
@@ -226,7 +226,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
+	struct gpio_desc	*cs_gpiod;	/* Chip select GPIO descriptor */
 	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
@@ -237,7 +237,7 @@ struct spi_device {
 	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/*
-	 * likely need more hooks for more protocol options affecting how
+	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
 	 *  - memory packing (12 bit samples into low bits, others zeroed)
 	 *  - priority
@@ -313,11 +313,11 @@ static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_d
 /**
  * struct spi_driver - Host side "protocol" driver
  * @id_table: List of SPI devices supported by this driver
- * @probe: Binds this driver to the spi device.  Drivers can verify
+ * @probe: Binds this driver to the SPI device.  Drivers can verify
  *	that the device is actually present, and may need to configure
  *	characteristics (such as bits_per_word) which weren't needed for
  *	the initial configuration done during system setup.
- * @remove: Unbinds this driver from the spi device
+ * @remove: Unbinds this driver from the SPI device
  * @shutdown: Standard shutdown callback used during system state
  *	transitions such as powerdown/halt and kexec
  * @driver: SPI device drivers should initialize the name and owner
@@ -429,7 +429,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queued: whether this controller is providing an internal message queue
  * @kworker: pointer to thread struct for message pump
  * @pump_messages: work struct for scheduling work to the message pump
- * @queue_lock: spinlock to syncronise access to message queue
+ * @queue_lock: spinlock to synchronise access to message queue
  * @queue: message queue
  * @cur_msg: the currently in-flight message
  * @cur_msg_completion: a completion for the current in-flight message
@@ -487,7 +487,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @target_abort: abort the ongoing transfer request on an SPI target controller
- * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
+ * @cs_gpiods: Array of GPIO descriptors to use as chip select lines; one per CS
  *	number. Any individual value may be NULL for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
  * @use_gpio_descriptors: Turns on the code in the SPI core to parse and grab
@@ -514,7 +514,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
  * @irq_flags: Interrupt enable state during PTP system timestamping
- * @fallback: fallback to pio if dma transfer return failure with
+ * @fallback: fallback to PIO if DMA transfer return failure with
  *	SPI_TRANS_FAIL_NO_START.
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
@@ -536,15 +536,17 @@ struct spi_controller {
 
 	struct list_head list;
 
-	/* Other than negative (== assign one dynamically), bus_num is fully
-	 * board-specific.  usually that simplifies to being SOC-specific.
-	 * example:  one SOC has three SPI controllers, numbered 0..2,
-	 * and one board's schematics might show it using SPI-2.  software
+	/*
+	 * Other than negative (== assign one dynamically), bus_num is fully
+	 * board-specific. Usually that simplifies to being SoC-specific.
+	 * example: one SoC has three SPI controllers, numbered 0..2,
+	 * and one board's schematics might show it using SPI-2. Software
 	 * would normally use bus_num=2 for that controller.
 	 */
 	s16			bus_num;
 
-	/* chipselects will be integral to many controllers; some others
+	/*
+	 * Chipselects will be integral to many controllers; some others
 	 * might use board-specific GPIOs.
 	 */
 	u16			num_chipselect;
@@ -590,8 +592,8 @@ struct spi_controller {
 	};
 
 	/*
-	 * on some hardware transfer / message size may be constrained
-	 * the limit may depend on device transfer settings
+	 * On some hardware transfer / message size may be constrained
+	 * the limit may depend on device transfer settings.
 	 */
 	size_t (*max_transfer_size)(struct spi_device *spi);
 	size_t (*max_message_size)(struct spi_device *spi);
@@ -609,7 +611,8 @@ struct spi_controller {
 	/* Flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
 
-	/* Setup mode and clock, etc (spi driver may call many times).
+	/*
+	 * Setup mode and clock, etc (SPI driver may call many times).
 	 *
 	 * IMPORTANT:  this may be called when transfers to another
 	 * device are active.  DO NOT UPDATE SHARED REGISTERS in ways
@@ -627,18 +630,19 @@ struct spi_controller {
 	 */
 	int (*set_cs_timing)(struct spi_device *spi);
 
-	/* Bidirectional bulk transfers
+	/*
+	 * Bidirectional bulk transfers
 	 *
 	 * + The transfer() method may not sleep; its main role is
 	 *   just to add the message to the queue.
 	 * + For now there's no remove-from-queue operation, or
 	 *   any other request management
-	 * + To a given spi_device, message queueing is pure fifo
+	 * + To a given spi_device, message queueing is pure FIFO
 	 *
 	 * + The controller's main job is to process its message queue,
 	 *   selecting a chip (for masters), then transferring data
 	 * + If there are multiple spi_device children, the i/o queue
-	 *   arbitration algorithm is unspecified (round robin, fifo,
+	 *   arbitration algorithm is unspecified (round robin, FIFO,
 	 *   priority, reservations, preemption, etc)
 	 *
 	 * + Chipselect stays active during the entire message
@@ -719,7 +723,7 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
-	/* gpio chip select */
+	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
 	s8			unused_native_cs;
@@ -803,7 +807,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 			     struct spi_transfer *xfer,
 			     size_t progress, bool irqs_off);
 
-/* The spi driver core manages memory for the spi_controller classdev */
+/* The SPI driver core manages memory for the spi_controller classdev */
 extern struct spi_controller *__spi_alloc_controller(struct device *host,
 						unsigned int size, bool slave);
 
@@ -892,13 +896,13 @@ typedef void (*spi_res_release_t)(struct spi_controller *ctlr,
 				  void *res);
 
 /**
- * struct spi_res - spi resource management structure
+ * struct spi_res - SPI resource management structure
  * @entry:   list entry
  * @release: release code called prior to freeing this resource
  * @data:    extra data allocated for the specific use-case
  *
- * this is based on ideas from devres, but focused on life-cycle
- * management during spi_message processing
+ * This is based on ideas from devres, but focused on life-cycle
+ * management during spi_message processing.
  */
 struct spi_res {
 	struct list_head        entry;
@@ -916,7 +920,7 @@ struct spi_res {
  *
  * The spi_messages themselves consist of a series of read+write transfer
  * segments.  Those segments always read the same number of bits as they
- * write; but one or the other is easily ignored by passing a null buffer
+ * write; but one or the other is easily ignored by passing a NULL buffer
  * pointer.  (This is unlike most types of I/O API, because SPI hardware
  * is full duplex.)
  *
@@ -927,8 +931,8 @@ struct spi_res {
 
 /**
  * struct spi_transfer - a read/write buffer pair
- * @tx_buf: data to be written (dma-safe memory), or NULL
- * @rx_buf: data to be read (dma-safe memory), or NULL
+ * @tx_buf: data to be written (DMA-safe memory), or NULL
+ * @rx_buf: data to be read (DMA-safe memory), or NULL
  * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
  * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
  * @tx_nbits: number of bits used for writing. If 0 the default
@@ -951,7 +955,7 @@ struct spi_res {
  * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
- *      transfer this transfer. Set to 0 if the spi bus driver does
+ *      transfer this transfer. Set to 0 if the SPI bus driver does
  *      not support it.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
@@ -980,16 +984,16 @@ struct spi_res {
  *	transmitting the "pre" word, and the "post" timestamp after receiving
  *	transmit confirmation from the controller for the "post" word.
  * @timestamped: true if the transfer has been timestamped
- * @error: Error status logged by spi controller driver.
+ * @error: Error status logged by SPI controller driver.
  *
  * SPI transfers always write the same number of bytes as they read.
  * Protocol drivers should always provide @rx_buf and/or @tx_buf.
  * In some cases, they may also want to provide DMA addresses for
  * the data being transferred; that may reduce overhead, when the
- * underlying driver uses dma.
+ * underlying driver uses DMA.
  *
- * If the transmit buffer is null, zeroes will be shifted out
- * while filling @rx_buf.  If the receive buffer is null, the data
+ * If the transmit buffer is NULL, zeroes will be shifted out
+ * while filling @rx_buf.  If the receive buffer is NULL, the data
  * shifted in will be discarded.  Only "len" bytes shift out (or in).
  * It's an error to try to shift out a partial word.  (For example, by
  * shifting out three bytes with word size of sixteen or twenty bits;
@@ -1023,7 +1027,7 @@ struct spi_res {
  * Some devices need protocol transactions to be built from a series of
  * spi_message submissions, where the content of one message is determined
  * by the results of previous messages and where the whole transaction
- * ends when the chipselect goes intactive.
+ * ends when the chipselect goes inactive.
  *
  * When SPI can transfer in 1x,2x or 4x. It can get this transfer information
  * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
@@ -1037,10 +1041,11 @@ struct spi_res {
  * and its transfers, ignore them until its completion callback.
  */
 struct spi_transfer {
-	/* It's ok if tx_buf == rx_buf (right?)
-	 * for MicroWire, one buffer must be null
-	 * buffers must work with dma_*map_single() calls, unless
-	 *   spi_message.is_dma_mapped reports a pre-existing mapping
+	/*
+	 * It's okay if tx_buf == rx_buf (right?).
+	 * For MicroWire, one buffer must be NULL.
+	 * Buffers must work with dma_*map_single() calls, unless
+	 * spi_message.is_dma_mapped reports a pre-existing mapping.
 	 */
 	const void	*tx_buf;
 	void		*rx_buf;
@@ -1060,9 +1065,9 @@ struct spi_transfer {
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
 	unsigned	timestamped:1;
-#define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
-#define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
-#define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
+#define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
+#define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
+#define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */
 	u8		bits_per_word;
 	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
@@ -1083,7 +1088,7 @@ struct spi_transfer {
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: list of transfer segments in this transaction
  * @spi: SPI device to which the transaction is queued
- * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
+ * @is_dma_mapped: if true, the caller provided both DMA and CPU virtual
  *	addresses for each transfer buffer
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
@@ -1093,7 +1098,7 @@ struct spi_transfer {
  * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
- * @resources: for resource management when the spi message is processed
+ * @resources: for resource management when the SPI message is processed
  * @prepared: spi_prepare_message was called for the this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
@@ -1120,7 +1125,8 @@ struct spi_message {
 	/* spi_prepare_message() was called for this message */
 	bool			prepared;
 
-	/* REVISIT:  we might want a flag affecting the behavior of the
+	/*
+	 * REVISIT: we might want a flag affecting the behavior of the
 	 * last transfer ... allowing things like "read 16 bit length L"
 	 * immediately followed by "read L bytes".  Basically imposing
 	 * a specific message scheduling algorithm.
@@ -1138,14 +1144,15 @@ struct spi_message {
 	unsigned		frame_length;
 	unsigned		actual_length;
 
-	/* For optional use by whatever driver currently owns the
+	/*
+	 * For optional use by whatever driver currently owns the
 	 * spi_message ...  between calls to spi_async and then later
 	 * complete(), that's the spi_controller controller driver.
 	 */
 	struct list_head	queue;
 	void			*state;
 
-	/* List of spi_res reources when the spi message is processed */
+	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
 };
 
@@ -1182,7 +1189,7 @@ spi_transfer_delay_exec(struct spi_transfer *t)
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized
- * @xfers: An array of spi transfers
+ * @xfers: An array of SPI transfers
  * @num_xfers: Number of items in the xfer array
  *
  * This function initializes the given spi_message and adds each spi_transfer in
@@ -1199,10 +1206,10 @@ struct spi_transfer *xfers, unsigned int num_xfers)
 		spi_message_add_tail(&xfers[i], m);
 }
 
-/* It's fine to embed message and transaction structures in other data
+/*
+ * It's fine to embed message and transaction structures in other data
  * structures so long as you don't free them while they're in use.
  */
-
 static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags)
 {
 	struct spi_message *m;
@@ -1305,7 +1312,7 @@ typedef void (*spi_replaced_release_t)(struct spi_controller *ctlr,
  *                                 replacements that have occurred
  *                                 so that they can get reverted
  * @release:            some extra release code to get executed prior to
- *                      relasing this structure
+ *                      releasing this structure
  * @extradata:          pointer to some extra data if requested or NULL
  * @replaced_transfers: transfers that have been replaced and which need
  *                      to get restored
@@ -1315,9 +1322,9 @@ typedef void (*spi_replaced_release_t)(struct spi_controller *ctlr,
  * @inserted_transfers: array of spi_transfers of array-size @inserted,
  *                      that have been replacing replaced_transfers
  *
- * note: that @extradata will point to @inserted_transfers[@inserted]
+ * Note: that @extradata will point to @inserted_transfers[@inserted]
  * if some extra allocation is requested, so alignment will be the same
- * as for spi_transfers
+ * as for spi_transfers.
  */
 struct spi_replaced_transfers {
 	spi_replaced_release_t release;
@@ -1343,7 +1350,8 @@ extern int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 
 /*---------------------------------------------------------------------------*/
 
-/* All these synchronous SPI transfer routines are utilities layered
+/*
+ * All these synchronous SPI transfer routines are utilities layered
  * over the core async transfer primitive.  Here, "synchronous" means
  * they will sleep uninterruptibly until the async transfer completes.
  */
@@ -1486,7 +1494,7 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
  *
  * Callable only from contexts that can sleep.
  *
- * Return: the (unsigned) sixteen bit number returned by the device in cpu
+ * Return: the (unsigned) sixteen bit number returned by the device in CPU
  * endianness, or else a negative error code.
  */
 static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
@@ -1514,7 +1522,7 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * As a rule, SPI devices can't be probed.  Instead, board init code
  * provides a table listing the devices which are present, with enough
  * information to bind and set up the device's driver.  There's basic
- * support for nonstatic configurations too; enough to handle adding
+ * support for non-static configurations too; enough to handle adding
  * parport adapters, or microcontrollers acting as USB-to-SPI bridges.
  */
 
@@ -1551,12 +1559,13 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * are active in some dynamic board configuration models.
  */
 struct spi_board_info {
-	/* The device name and module name are coupled, like platform_bus;
+	/*
+	 * The device name and module name are coupled, like platform_bus;
 	 * "modalias" is normally the driver name.
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
 	 * controller_data goes to spi_device.controller_data,
-	 * irq is copied too
+	 * IRQ is copied too.
 	 */
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
@@ -1568,7 +1577,8 @@ struct spi_board_info {
 	u32		max_speed_hz;
 
 
-	/* bus_num is board specific and matches the bus_num of some
+	/*
+	 * bus_num is board specific and matches the bus_num of some
 	 * spi_controller that will probably be registered later.
 	 *
 	 * chip_select reflects how this chip is wired to that master;
@@ -1577,12 +1587,14 @@ struct spi_board_info {
 	u16		bus_num;
 	u16		chip_select;
 
-	/* mode becomes spi_device.mode, and is essential for chips
+	/*
+	 * mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
 	u32		mode;
 
-	/* ... may need additional spi_device chip config data here.
+	/*
+	 * ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
 	 * needed to behave without being bound to a driver:
 	 *  - quirks like clock rate mattering when not selected
@@ -1599,7 +1611,8 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	{ return 0; }
 #endif
 
-/* If you're hotplugging an adapter with devices (parport, usb, etc)
+/*
+ * If you're hotplugging an adapter with devices (parport, USB, etc)
  * use spi_new_device() to describe each device.  You can also call
  * spi_unregister_device() to start making that device vanish, but
  * normally that would be handled by spi_unregister_controller().
-- 
2.40.0.1.gaa8946217a0b

