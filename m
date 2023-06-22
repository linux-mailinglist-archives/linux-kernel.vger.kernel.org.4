Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA3739F39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFVLEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFVLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:04:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A591FC2;
        Thu, 22 Jun 2023 04:04:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35MB4CN8125292;
        Thu, 22 Jun 2023 06:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687431852;
        bh=pXUloh+GGjx48h+NbhRCa5ftlVWH49ZJ9BKG4vKpKLw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r+1HyeN61u2sOHQARlBo5a70TcWKGl/aj/iGplkcTmkrJgdLjIVhPqrOF1VF/5qY8
         Pm90sEwdoDoGf2EPaoikd6RDLvZTGEEaVnF1n5i9zNqaeZ+ReGcB0US491f2YAD7Nz
         9krLMBKL53DakCCvXzp3vBtwd77aEsdpvKmCR7EQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35MB4C4u081404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Jun 2023 06:04:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Jun 2023 06:04:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Jun 2023 06:04:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35MB4AUd002211;
        Thu, 22 Jun 2023 06:04:11 -0500
Date:   Thu, 22 Jun 2023 16:34:10 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Julien Massot <julien.massot@collabora.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mripard@kernel.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <bparrot@ti.com>, <niklas.soderlund+renesas@ragnatech.se>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v7 00/13] CSI2RX support on J721E
Message-ID: <twku7ip44f4apr2ccjdd7qti5xob7ug6bqiitjogmnmn2j5dnq@g25qkygspyw6>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <28707378-c4e7-38b6-48f5-63b0834c18c9@ideasonboard.com>
 <512f54f5-60d5-db68-dce3-96cf70519b6c@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhwy664zkhk6fffo"
Content-Disposition: inline
In-Reply-To: <512f54f5-60d5-db68-dce3-96cf70519b6c@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mhwy664zkhk6fffo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julien,

On Jun 22, 2023 at 11:18:28 +0200, Julien Massot wrote:
> Hi Vaishnav,
>=20
>  On 14/03/2023 13:55, Vaishnav Achath wrote:
> > Hi,
> >=20
> > This series adds support for CSI2 capture on J721E. It includes some
> > fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper
> > driver.
> We are testing this patch series and experienced some strange behaviour,
> with the same sequence of 5-10 frames repeated over and over.
> (Almost the same sequence since frames have different md5sum)
>=20
> To solve this issue we had to forward port some functions from the TI BSP
> Kernel[1] such as ti_csi2rx_restart_dma, and ti_csi2rx_drain_dma.
>=20
> Can you consider this issue for the next patchset version?

While we haven't seen this particular issue (of repeating frames) due to=20
a lack of draining, I agree that it is a useful fix.

Will include it in v8 of this series along with some other features and=20
fixes around stream stop sequence.

Thanks,

>=20
> Thank you,
> Julien
>=20
>=20
> Here are the modifications we made for information only.
>=20
> ---
>  .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 138 +++++++++++++++---
>  1 file changed, 117 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> index 1af7b0b09cfc..e8579dbf07b4 100644
> --- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> @@ -46,6 +46,8 @@
>  #define MAX_WIDTH_BYTES			SZ_16K
>  #define MAX_HEIGHT_LINES		SZ_16K
>=20
> +#define DRAIN_TIMEOUT_MS		50
> +
>  struct ti_csi2rx_fmt {
>  	u32				fourcc;	/* Four character code. */
>  	u32				code;	/* Mbus code. */
> @@ -498,6 +500,59 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev
> *csi)
>  	writel(reg, csi->shim + SHIM_PSI_CFG0);
>  }
>=20
> +static void ti_csi2rx_drain_callback(void *param)
> +{
> +	struct completion *drain_complete =3D param;
> +
> +	complete(drain_complete);
> +}
> +
> +static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
> +{
> +	struct dma_async_tx_descriptor *desc;
> +	struct device *dev =3D csi->dma.chan->device->dev;
> +	struct completion drain_complete;
> +	void *buf;
> +	size_t len =3D csi->v_fmt.fmt.pix.sizeimage;
> +	dma_addr_t addr;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	init_completion(&drain_complete);
> +
> +	buf =3D dma_alloc_coherent(dev, len, &addr, GFP_KERNEL | GFP_ATOMIC);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	desc =3D dmaengine_prep_slave_single(csi->dma.chan, addr, len,
> +					   DMA_DEV_TO_MEM,
> +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	desc->callback =3D ti_csi2rx_drain_callback;
> +	desc->callback_param =3D &drain_complete;
> +
> +	cookie =3D dmaengine_submit(desc);
> +	ret =3D dma_submit_error(cookie);
> +	if (ret)
> +		goto out;
> +
> +	dma_async_issue_pending(csi->dma.chan);
> +
> +	if (!wait_for_completion_timeout(&drain_complete,
> +					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
> +		dmaengine_terminate_sync(csi->dma.chan);
> +		ret =3D -ETIMEDOUT;
> +		goto out;
> +	}
> +out:
> +	dma_free_coherent(dev, len, buf, addr);
> +	return ret;
> +}
> +
>  static void ti_csi2rx_dma_callback(void *param)
>  {
>  	struct ti_csi2rx_buffer *buf =3D param;
> @@ -564,24 +619,61 @@ static int ti_csi2rx_start_dma(struct ti_csi2rx_dev
> *csi,
>  }
>=20
>  static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
> -				      enum vb2_buffer_state state)
> +				      enum vb2_buffer_state buf_state)
>  {
>  	struct ti_csi2rx_dma *dma =3D &csi->dma;
> -	struct ti_csi2rx_buffer *buf =3D NULL, *tmp;
> +	struct ti_csi2rx_buffer *buf =3D NULL, *tmp, *curr;;
> +	enum ti_csi2rx_dma_state state;
>  	unsigned long flags;
> +	int ret;
>=20
>  	spin_lock_irqsave(&dma->lock, flags);
>  	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
>  		list_del(&buf->list);
> -		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
>  	}
>=20
> -	if (dma->curr)
> -		vb2_buffer_done(&dma->curr->vb.vb2_buf, state);
> -
> +	curr =3D csi->dma.curr;
> +	state =3D csi->dma.state;
>  	dma->curr =3D NULL;
>  	dma->state =3D TI_CSI2RX_DMA_STOPPED;
>  	spin_unlock_irqrestore(&dma->lock, flags);
> +
> +	if (state !=3D TI_CSI2RX_DMA_STOPPED) {
> +		ret =3D ti_csi2rx_drain_dma(csi);
> +		if (ret)
> +			dev_dbg(csi->dev,
> +				"Failed to drain DMA. Next frame might be bogus\n");
> +		dmaengine_terminate_sync(csi->dma.chan);
> +	}
> +
> +	if (curr)
> +		vb2_buffer_done(&curr->vb.vb2_buf, buf_state);
> +}
> +
> +static int ti_csi2rx_restart_dma(struct ti_csi2rx_dev *csi,
> +				 struct ti_csi2rx_buffer *buf)
> +{
> +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> +	unsigned long flags =3D 0;
> +	int ret =3D 0;
> +
> +	ret =3D ti_csi2rx_drain_dma(csi);
> +	if (ret)
> +		dev_warn(csi->dev,
> +			 "Failed to drain DMA. Next frame might be bogus\n");
> +
> +	ret =3D ti_csi2rx_start_dma(csi, buf);
> +	if (ret) {
> +		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> +		spin_lock_irqsave(&dma->lock, flags);
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +		dma->curr =3D NULL;
> +		dma->state =3D TI_CSI2RX_DMA_IDLE;
> +		spin_unlock_irqrestore(&dma->lock, flags);
> +	}
> +
> +	return ret;
>  }
>=20
>  static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int
> *nbuffers,
> @@ -622,6 +714,7 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer
> *vb)
>  	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct ti_csi2rx_buffer *buf;
>  	struct ti_csi2rx_dma *dma =3D &csi->dma;
> +	bool restart_dma =3D false;
>  	unsigned long flags =3D 0;
>  	int ret;
>=20
> @@ -634,21 +727,30 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer
> *vb)
>  	 * But if DMA has stalled due to lack of buffers, restart it now.
>  	 */
>  	if (dma->state =3D=3D TI_CSI2RX_DMA_IDLE) {
> -		ret =3D ti_csi2rx_start_dma(csi, buf);
> -		if (ret) {
> -			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> -			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
> -			goto unlock;
> -		}
> -
> +		/*
> +		 * Do not restart DMA with the lock held because
> +		 * ti_csi2rx_drain_dma() might block when allocating a buffer.
> +		 * There won't be a race on queueing DMA anyway since the
> +		 * callback is not being fired.
> +		 */
> +		restart_dma =3D true;
>  		dma->curr =3D buf;
>  		dma->state =3D TI_CSI2RX_DMA_ACTIVE;
>  	} else {
>  		list_add_tail(&buf->list, &dma->queue);
>  	}
> -
> -unlock:
>  	spin_unlock_irqrestore(&dma->lock, flags);
> +
> +	if (restart_dma) {
> +		/*
> +		 * Once frames start dropping, some data gets stuck in the DMA
> +		 * pipeline somewhere. So the first DMA transfer after frame
> +		 * drops gives a partial frame. This is obviously not useful to
> +		 * the application and will only confuse it. Issue a DMA
> +		 * transaction to drain that up.
> +		 */
> +		ti_csi2rx_restart_dma(csi, buf);
> +	}
>  }
>=20
>  static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int
> count)
> @@ -718,12 +820,6 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue
> *vq)
>=20
>  	writel(0, csi->shim + SHIM_CNTL);
>=20
> -	ret =3D dmaengine_terminate_sync(csi->dma.chan);
> -	if (ret)
> -		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
> -
> -	writel(0, csi->shim + SHIM_DMACNTX);
> -
>  	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_ERROR);
>  }
>=20
> --=20
> 2.41.0
>=20
>=20
> [1] TI BSP kernel : https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kern=
el/tree/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c?h=3Dti-linux-=
6.1.y-cicd
>=20
> --=20
> Julien Massot
> Senior Software Engineer
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718

--
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--mhwy664zkhk6fffo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmSUKqYACgkQQ96R+SSa
cUXFzBAArv0i+KTbzN3eFaZPD9h2pZB0mILld88CfZAfWKDtf5NUsM+YjEjCwAN+
eZN54OQ3ZnR1Ptp86usQgfoqV/37cehsRZIMN/a9AIFv5x56Nmgd6doH8q/Fz8Ig
1BtLHlt8rRZQn45zwGupzORk2U+uaaCWyhsh0RXiJ/e3P7egd6GTqQBWPlaImKBn
N/UZSKJ0DFR0lTqXAOzbZJtbOk70Yy4TuhT7RXN0P+PS+0ftGVh9zthd7CabuT5o
ve+ne90OyeEs++JeStVwRtPC2xDMFBFEzFAvIU+40DyPjF7DE5/xuc2lQF2omNZX
qDENei+wtdPC9ovL3uFuWu9hz/oh0usrB10dy7c0BurSkn/E63qK72HVarMqLrBf
E4F+JYZE06v3KsLp0gvfKkTIRsiqc0ESceZlwGq5NRrJGXlnSocEW6LXKFtZ7j6F
a8VVcrx06jmJzRjWN8ZP9YR89OlkT0wHnPjkc4DT/vtLWkyOaYl/CPCWRIosHwty
UKY4EdzxRk5yhMSDx3Obcq8DQKoD8ukIpqh377FVBwmujxm7BekTEl60ZZKjixd4
N/P8JEsGk5EyVi96+FrIdbAiaJCGnSDrd6jWMEOLEVwXUhWgO/UFWYWjYqUhGd6N
WaFfrpgojQGDq63ps5rBx8RNe3K0BeHw1gUKlVrrbwRzczfAahY=
=GOwf
-----END PGP SIGNATURE-----

--mhwy664zkhk6fffo--
