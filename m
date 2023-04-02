Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFB6D3755
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjDBKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDBKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:35:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70410A87;
        Sun,  2 Apr 2023 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680431699; x=1711967699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zg1OHTHWiO0Fl0PxVnUnL4mHARomSjm0qo9g9w/xg6Q=;
  b=PFQ7palhUIMY/GQDQ+zFHNIsLbxB7jZ7TDHFnRxS48pfPHUpq0Gg+Z/v
   f9TFo/3Q/GGEuII3G4DH+Fsh9m97+qOaH+XaZxYmi7l4g0aUTGPgAM9HL
   2fj4mOIwHjaad3YW7Ie7nLQcvUEjYBVauNjSPuKwBpwfSpiwdzyIBRnX1
   b6Ma7C2gjSQBMImzcqhwE6zaDlb8F9QMrnQR+XM2CN1YlsrIHyMoMbYtD
   QYt/XHJxPWKhGdLHxlfBXa2Q9ivel8FwLnLiMyPgzEz1pMoC17IO/DibZ
   m1/Q0OC49j+DnuQDFmnW72cr1BeJM5C5xN8/ZKd97H+Dv4ZflgyiTNGBP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="325720500"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="325720500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 03:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="662887072"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="662887072"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2023 03:34:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piv31-000NMN-1A;
        Sun, 02 Apr 2023 10:34:55 +0000
Date:   Sun, 2 Apr 2023 18:34:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        v9fs-developer@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH] fs/9p: Rework cache modes and add new options to
 Documentation
Message-ID: <202304021848.dGo1cazM-lkp@intel.com>
References: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 1543b4c5071c54d76aad7a7a26a6e43082269b0c]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Van-Hensbergen/fs-9p-Rework-cache-modes-and-add-new-options-to-Documentation/20230402-071815
base:   1543b4c5071c54d76aad7a7a26a6e43082269b0c
patch link:    https://lore.kernel.org/r/20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a%40kernel.org
patch subject: [PATCH] fs/9p: Rework cache modes and add new options to Documentation
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/8d563b947e70b7fe9a067ef3be10471a05452505
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-Van-Hensbergen/fs-9p-Rework-cache-modes-and-add-new-options-to-Documentation/20230402-071815
        git checkout 8d563b947e70b7fe9a067ef3be10471a05452505
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304021848.dGo1cazM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/9p.rst:92: WARNING: Malformed table.

vim +92 Documentation/filesystems/9p.rst

    58	
    59	  ============= ===============================================================
    60	  trans=name	select an alternative transport.  Valid options are
    61	  		currently:
    62	
    63				========  ============================================
    64				unix 	  specifying a named pipe mount point
    65				tcp	  specifying a normal TCP/IP connection
    66				fd   	  used passed file descriptors for connection
    67	                                  (see rfdno and wfdno)
    68				virtio	  connect to the next virtio channel available
    69					  (from QEMU with trans_virtio module)
    70				rdma	  connect to a specified RDMA channel
    71				========  ============================================
    72	
    73	  uname=name	user name to attempt mount as on the remote server.  The
    74	  		server may override or ignore this value.  Certain user
    75			names may require authentication.
    76	
    77	  aname=name	aname specifies the file tree to access when the server is
    78	  		offering several exported file systems.
    79	
    80	  cache=mode	specifies a caching policy.  By default, no caches are used.
    81			The mode can be specified as a bitmask or by using one of the
    82			prexisting common 'shortcuts'.
    83			The bitmask is described below: (unspecified bits are reserved)
    84	
    85				==========	================================================
    86				0b00000000	all caches disabled, mmap disabled
    87				0b00000001	file caches enabled
    88				0b00000010	meta-data caches enabled
    89				0b00000100	writeback behavior (as opposed to writethrough)
    90				0b00001000	loose caches (no explicit consistency with server)
    91				0b10000000	fscache enabled for persistent caching
  > 92				=========	================================================
    93	
    94			The current shortcuts and their associated bitmask are:
    95	
    96				=========	=============================================
    97				none		0b00000000 (no caching)
    98				readahead	0b00000001 (only read-ahead file caching)
    99				mmap		0b00000101 (read-ahead + writeback file cache)
   100				loose		0b00001111 (non-coherent file and meta-data caches)
   101				fscache		0b10001111 (persistent loose cache)
   102				=========	=============================================
   103	
   104			NOTE: only these shortcuts are tested modes of operation at the
   105			moment, so using other combinations of bit-patterns is not
   106			known to work.  Work on better cache support is in progress.
   107	
   108			IMPORTANT: loose caches (and by extension at the moment fscache)
   109			do not necessarily validate cached values on the server.  In other
   110			words changes on the server are not guaranteed to be reflected
   111			on the client system.  Only use this mode of operation if you
   112			have an exclusive mount and the server will modify the filesystem
   113			underneath you.
   114	
   115	  debug=n	specifies debug level.  The debug level is a bitmask.
   116	
   117				=====   ================================
   118				0x01    display verbose error messages
   119				0x02    developer debug (DEBUG_CURRENT)
   120				0x04    display 9p trace
   121				0x08    display VFS trace
   122				0x10    display Marshalling debug
   123				0x20    display RPC debug
   124				0x40    display transport debug
   125				0x80    display allocation debug
   126				0x100   display protocol message debug
   127				0x200   display Fid debug
   128				0x400   display packet debug
   129				0x800   display fscache tracing debug
   130				=====   ================================
   131	
   132	  rfdno=n	the file descriptor for reading with trans=fd
   133	
   134	  wfdno=n	the file descriptor for writing with trans=fd
   135	
   136	  msize=n	the number of bytes to use for 9p packet payload
   137	
   138	  port=n	port to connect to on the remote server
   139	
   140	  noextend	force legacy mode (no 9p2000.u or 9p2000.L semantics)
   141	
   142	  version=name	Select 9P protocol version. Valid options are:
   143	
   144				========        ==============================
   145				9p2000          Legacy mode (same as noextend)
   146				9p2000.u        Use 9P2000.u protocol
   147				9p2000.L        Use 9P2000.L protocol
   148				========        ==============================
   149	
   150	  dfltuid	attempt to mount as a particular uid
   151	
   152	  dfltgid	attempt to mount with a particular gid
   153	
   154	  afid		security channel - used by Plan 9 authentication protocols
   155	
   156	  nodevmap	do not map special files - represent them as normal files.
   157	  		This can be used to share devices/named pipes/sockets between
   158			hosts.  This functionality will be expanded in later versions.
   159	
   160	  directio	bypass page cache on all read/write operations
   161	
   162	  ignoreqv	ignore qid.version==0 as a marker to ignore cache
   163	
   164	  noxattr	do not offer xattr functions on this mount.
   165	
   166	  access	there are four access modes.
   167				user
   168					if a user tries to access a file on v9fs
   169				        filesystem for the first time, v9fs sends an
   170				        attach command (Tattach) for that user.
   171					This is the default mode.
   172				<uid>
   173					allows only user with uid=<uid> to access
   174					the files on the mounted filesystem
   175				any
   176					v9fs does single attach and performs all
   177					operations as one user
   178				clien
   179					 ACL based access check on the 9p client
   180				         side for access validation
   181	
   182	  cachetag	cache tag to use the specified persistent cache.
   183			cache tags for existing cache sessions can be listed at
   184			/sys/fs/9p/caches. (applies only to cache=fscache)
   185	  ============= ===============================================================
   186	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
