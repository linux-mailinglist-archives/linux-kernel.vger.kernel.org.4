Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60D61761B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKCF0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKCF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:26:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294717072
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:26:00 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221103052557epoutp03159a65d720137f0349fc3cad230fe8f9~j_8-1Y7cP0947909479epoutp03k
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:25:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221103052557epoutp03159a65d720137f0349fc3cad230fe8f9~j_8-1Y7cP0947909479epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667453157;
        bh=N6OstaZqGaKmMYklgkBVwBadufwTTLXmst0xPYUQmRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LnFdmrYXrgOeJSDmDs8SUoNfEdSigJ5Dp762TyfyMHrNoNyJIwxLi2GMEAVeKif1X
         z6GL6Jz/F5w2x0qLo2BYcaHbABHXnA0UWM1eGJjLo6WzmZLEPgNdp+koBlbxb1E18h
         SEcZ/IomMpbkVy7Eou7OLQToNCJ2Gug68XfVnsC4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221103052556epcas1p4323dee8ef7c89549b1b606cc53bed32e~j_8-IY2ln1028810288epcas1p4M;
        Thu,  3 Nov 2022 05:25:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N2sfq6KqGz4x9Q7; Thu,  3 Nov
        2022 05:25:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.CB.20046.3E053636; Thu,  3 Nov 2022 14:25:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103052555epcas1p24b9f02c98b83fdc805b5817b85df7f80~j_89vaMyY0582505825epcas1p2i;
        Thu,  3 Nov 2022 05:25:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221103052555epsmtrp209076225c95c094cee9e5c2916c56cd6~j_89tm__e1917019170epsmtrp2I;
        Thu,  3 Nov 2022 05:25:55 +0000 (GMT)
X-AuditID: b6c32a39-35fff70000004e4e-81-636350e382b3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.48.18644.3E053636; Thu,  3 Nov 2022 14:25:55 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221103052555epsmtip1feef47f5f5417d27bbc7655435bc939d~j_89af4Q23156231562epsmtip1Z;
        Thu,  3 Nov 2022 05:25:55 +0000 (GMT)
Date:   Thu, 3 Nov 2022 14:25:54 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/3] accel: add dedicated minor for accelerator
 devices
Message-Id: <20221103142554.6310a60f0f6dad1a59fa7644@samsung.com>
In-Reply-To: <20221102203405.1797491-3-ogabbay@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/fW2t62z5FpQfnZLKHeQTTaghZb9YEBE0NyEZcPA/GOLYV17
        Ax3Qdm3ZlG3yGspz8hZ5OJ4WWMFQkafoBigiaGASZAnIkrlhDG8GIgxdy8W5/77n/D7nnN85
        J4eHCTO5Ip5aY6T1GkUsie9mt/Ud9HT/I0yplDzplKLbD6pZqHiym4O28m9x0Yu2PAyNpZ3n
        oLHVBRyl1lzG0VCuFSm8t8VBf1tycTT2/BpALX9Wc9FCVjeGnp1tZaH7XeU4qlq6ykbJqRMY
        OpNxiYOuZy8BNFy1jqGB5wmodTbPmnMm7JAj1bQ0zaHSft3Cqc2NfEAtTKRxqZ61Sjb1eLUN
        ozpLp7jUlXo3ytKYgVMXB49RNyrMXGo6a4BF5aTO41TetdPUD62NgLoy9E2Y8JMY/2haoaL1
        Ylqj1KrUmqgAMjQ8MjhS7iORukt90XukWKOIowPIkA/C3I+qY62DIMVfKWLjra4whcFAegb6
        67XxRlocrTUYA0hap4rVyXUeBkWcIV4T5aGhjX5SicRLbgU/i4kuOJfF0Q3vObkykoongTV+
        JuDzICGDZWXJIBPs5gmJDgB7usYxxlgGMNW0yGKMFQAtTf2slyGWiQLMpoVEF4C5KQ4MlM6C
        v5VUcG0PbMIFPnxxc1vjhCu8UGK2ah7PweofrZPZeIxYxOFsSxHHxtgTEbA7ZxG3aQERBB8X
        PdiO5RN+cKg2j80URnAqu55jyyMg9sKtDnubGyOcYPtc+favIdHOhzn9DzGGD4Hm2Ukuo+3h
        k4HWHS2CK/M9OKNjYGF69U5+Hbw3cxWz5YeENxytV9kkRhyEl7s8GcIZdm5WAKasHZxfzeYw
        tACmnxEyCAlr/+nbKQRhUckai0EoeLPtHWZQPQDeqcrEcoG49FUvpf/rpfRV3UqANYL9tM4Q
        F0UbpDr5f9tVauMsYPso3Hw7wPm5RY9ewOKBXgB5GOkgSLz7qVIoUClOJdB6baQ+PpY29AK5
        dTF5mGifUmu9Ko0xUirzlch8vLxlSOojJR0FSSVuSiERpTDSMTSto/Uv41g8viiJVT6VXPP7
        rtrCY2XDLaFdDocrM+b+2uhLVxcoNWb7anJS7G3CPcvAwvFDgS4H6hNHB8cUB55OJch/CvfH
        Pq4pdjWJvouXuZ0KlX7e/W7FkfB8uZPDzIUG/4v6pyPNPs5rj+xO+JsaLkXsMu9rLzc3cVUh
        vi23+yPvvl/r/HN7gzEz7vvgwBuvn/u6aDzx7KDjifas+mXCr8hUN+o5on7Le/xHtfFo8y+D
        y6vNwUaniOv6R9Otd968VRhbvP+N9Qlxw7dxFS7PTquP53tXD7zW7uVM7sn64svDdfi6Kec+
        aRG9XQU/sk+U7/3QgG8GFnulSDaqEqJmgnKDhAWuY/yTJru0lBWSbYhWSN0wvUHxLww+jryd
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSnO7jgORkg/43ghYnri9isph2Zzer
        xd9Jx9gt/m+byGxxpXU6q8WVr+/ZLJoXr2ezOD0BqGTKub+sFl82TWCzuPJvD6PFxqeL2C3e
        d+9mtvjZvoXJ4vKuOWwWCz9uZbFobL7BbNHWuYzVYl/PR0aLMwt/MFsc/1dlseXNRKCZzwMc
        xD3WfrzP6tF66S+bx+9fkxg93t9oZffY+20Bi8eLr9uYPXbOusvusXmFlsemVZ1sHvNOBnrs
        n7uG3eN+93Emj97md2weE/fUefRtWcXosfl0dYBQFJdNSmpOZllqkb5dAlfG5P5u1oIzPBWf
        LzSzNTB+4+xi5OSQEDCR2HRjMnMXIxeHkMAORomVLX1MEAkJiU33lgMlOIBsYYnDh4shatqY
        JA7fv80GUsMioCJx7/9RdhCbTUBVYuaMNewg9SJA8YtLTUDqmQU+sEns2z6TFaRGWCBEYnfv
        B7BeXgFHiRdTr4P1cgpYSZxeMpEFYsFeRolTC7uYIY6wkLjbs4IVZCivgKDE3x3CIGFmAS2J
        h79usUDY8hLb385hnsAoOAuhahaSqllIqhYwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
        zs/dxAhOA1paOxj3rPqgd4iRiYPxEKMEB7OSCG/92ehkId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiOBnrti1pTvjz0abo6G49IwJxXU7RbpE7ZG0y+
        JZxnYySdGb4+zeNpaOISTeFE24KyDvXNrtJFgtnyyT3GAjwzQw+/m3mlIyrep/DpmW1LTSJO
        PD21jfNOe90DqdY6JwbGHIa+Ois90yMKS5IWtvHMXfor7kMl38wy3js/HrP0zfdMemH27FvG
        vbOpEg97jxR+TNdQ9he7Nv1szmtOlV1GojJGk9xzJuddZ/dytdzlW1JroBmfdpLxSkd2+lsB
        f35XgX7uT5pNNybvzozxDtRduaQ57bC5TguHUM2u/e586ntORc7dkzCFVYrLX1or83V/3F4h
        rbPn5eer+viXVNQxMj3q4cyfnNwfkKDEUpyRaKjFXFScCABNxAygcgMAAA==
X-CMS-MailID: 20221103052555epcas1p24b9f02c98b83fdc805b5817b85df7f80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102203430epcas1p380845d7a6ebc38ab1f41acf8c48a4480
References: <20221102203405.1797491-1-ogabbay@kernel.org>
        <CGME20221102203430epcas1p380845d7a6ebc38ab1f41acf8c48a4480@epcas1p3.samsung.com>
        <20221102203405.1797491-3-ogabbay@kernel.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Nov 2022 22:34:04 +0200
Oded Gabbay <ogabbay@kernel.org> wrote:

> +/**
> + * accel_open - open method for ACCEL file
> + * @inode: device inode
> + * @filp: file pointer.
> + *
> + * This function must be used by drivers as their &file_operations.open method.
> + * It looks up the correct ACCEL device and instantiates all the per-file
> + * resources for it. It also calls the &drm_driver.open driver callback.
> + *
> + * Return: 0 on success or negative errno value on failure.
> + */
> +int accel_open(struct inode *inode, struct file *filp)
> +{
> +	struct drm_device *dev;
> +	struct drm_minor *minor;
> +	int retcode;
> +
> +	minor = accel_minor_acquire(iminor(inode));
> +	if (IS_ERR(minor))
> +		return PTR_ERR(minor);
> +
> +	dev = minor->dev;
> +
> +	atomic_fetch_inc(&dev->open_count);
> +

Hi,
It needs to consider drm_global_mutex to access open_count.
please check doxy of open_count.


> +	/* share address_space across all char-devs of a single device */
> +	filp->f_mapping = dev->anon_inode->i_mapping;
> +
> +	retcode = drm_open_helper(filp, minor);
> +	if (retcode)
> +		goto err_undo;
> +
> +	return 0;
> +
> +err_undo:
> +	atomic_dec(&dev->open_count);
> +	accel_minor_release(minor);
> +	return retcode;
> +}
> +EXPORT_SYMBOL_GPL(accel_open);
> +
>  static int accel_stub_open(struct inode *inode, struct file *filp)
>  {
> -	DRM_DEBUG("Operation not supported");
> +	const struct file_operations *new_fops;
> +	struct drm_minor *minor;
> +	int err;
> +
> +	DRM_DEBUG("\n");

It seems useless.

Thanks.
Jiho Chu
