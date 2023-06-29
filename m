Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4E7421DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF2IRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2IQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:16:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72544B5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688025919; x=1719561919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LNVI2yAmEsk7VzkRVfXgG0nVYALPRe4uiCGczyx23ic=;
  b=kvCB0FnfQsz6sBWnTGUMHu0AUCiQBSZEtkbyEiXnjq/M7iOl6wYiLUeM
   LLFhRRdzButhljzoRSBAk77Rr4FeM0uKsaMljhB6RYrbG33ErTw2ATUVK
   5OJoMZvcyuXcjdr9Vgk0ET/lmeqLB8GE8ptyPKs4c2KWZFe6dcAkodQDh
   /MvrOXDLR3Aww2n4jlB75QYeFWaX2ihy04duuWF8jiV7P9daVVl4Zmm3a
   Rs4x3evoBuz+/CG0UTkifR1qc45ll0z+GGN9GOdKXBcEC6POzOz5fES9/
   aUavjXktVraK6JbE4tkACeYT1u7RCF1u4ToYXrup3wfRNzEh15S2ZYu2j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364596591"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="364596591"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="807220315"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="807220315"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 01:05:16 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEmeR-000Dym-2u;
        Thu, 29 Jun 2023 08:05:15 +0000
Date:   Thu, 29 Jun 2023 16:04:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Marco Elver <elver@google.com>
Subject: fs/ntfs/file.c:1725:16: warning: stack frame size (2080) exceeds
 limit (2048) in 'ntfs_perform_write'
Message-ID: <202306291537.pEJwYR5u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a8a670eeeaa40d87bd38a587438952741980c18
commit: b03fc1173c0c2bb8fad61902a862985cecdc4b1b bitops: let optimize out non-atomic bitops on compile-time constants
date:   12 months ago
config: riscv-randconfig-r026-20230629 (https://download.01.org/0day-ci/archive/20230629/202306291537.pEJwYR5u-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291537.pEJwYR5u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291537.pEJwYR5u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ntfs/file.c:1725:16: warning: stack frame size (2080) exceeds limit (2048) in 'ntfs_perform_write' [-Wframe-larger-than]
    1725 | static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
         |                ^
   fs/ntfs/file.c:568:12: warning: stack frame size (2384) exceeds limit (2048) in 'ntfs_prepare_pages_for_non_resident_write' [-Wframe-larger-than]
     568 | static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
         |            ^
   2 warnings generated.


vim +/ntfs_perform_write +1725 fs/ntfs/file.c

9014da7525dffe Marco Stornelli     2012-12-15  1718  
98b270362bb9ea Anton Altaparmakov  2005-10-11  1719  /**
a632f559304130 Anton Altaparmakov  2015-03-11  1720   * ntfs_perform_write - perform buffered write to a file
a632f559304130 Anton Altaparmakov  2015-03-11  1721   * @file:	file to write to
a632f559304130 Anton Altaparmakov  2015-03-11  1722   * @i:		iov_iter with data to write
a632f559304130 Anton Altaparmakov  2015-03-11  1723   * @pos:	byte offset in file at which to begin writing to
98b270362bb9ea Anton Altaparmakov  2005-10-11  1724   */
a632f559304130 Anton Altaparmakov  2015-03-11 @1725  static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
a632f559304130 Anton Altaparmakov  2015-03-11  1726  		loff_t pos)
98b270362bb9ea Anton Altaparmakov  2005-10-11  1727  {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1728  	struct address_space *mapping = file->f_mapping;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1729  	struct inode *vi = mapping->host;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1730  	ntfs_inode *ni = NTFS_I(vi);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1731  	ntfs_volume *vol = ni->vol;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1732  	struct page *pages[NTFS_MAX_PAGES_PER_CLUSTER];
98b270362bb9ea Anton Altaparmakov  2005-10-11  1733  	struct page *cached_page = NULL;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1734  	VCN last_vcn;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1735  	LCN lcn;
a632f559304130 Anton Altaparmakov  2015-03-11  1736  	size_t bytes;
a632f559304130 Anton Altaparmakov  2015-03-11  1737  	ssize_t status, written = 0;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1738  	unsigned nr_pages;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1739  
a632f559304130 Anton Altaparmakov  2015-03-11  1740  	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
a632f559304130 Anton Altaparmakov  2015-03-11  1741  			"0x%llx, count 0x%lx.", vi->i_ino,
a632f559304130 Anton Altaparmakov  2015-03-11  1742  			(unsigned)le32_to_cpu(ni->type),
a632f559304130 Anton Altaparmakov  2015-03-11  1743  			(unsigned long long)pos,
a632f559304130 Anton Altaparmakov  2015-03-11  1744  			(unsigned long)iov_iter_count(i));
98b270362bb9ea Anton Altaparmakov  2005-10-11  1745  	/*
98b270362bb9ea Anton Altaparmakov  2005-10-11  1746  	 * If a previous ntfs_truncate() failed, repeat it and abort if it
98b270362bb9ea Anton Altaparmakov  2005-10-11  1747  	 * fails again.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1748  	 */
98b270362bb9ea Anton Altaparmakov  2005-10-11  1749  	if (unlikely(NInoTruncateFailed(ni))) {
a632f559304130 Anton Altaparmakov  2015-03-11  1750  		int err;
a632f559304130 Anton Altaparmakov  2015-03-11  1751  
bd5fe6c5eb9c54 Christoph Hellwig   2011-06-24  1752  		inode_dio_wait(vi);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1753  		err = ntfs_truncate(vi);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1754  		if (err || NInoTruncateFailed(ni)) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1755  			if (!err)
98b270362bb9ea Anton Altaparmakov  2005-10-11  1756  				err = -EIO;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1757  			ntfs_error(vol->sb, "Cannot perform write to inode "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1758  					"0x%lx, attribute type 0x%x, because "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1759  					"ntfs_truncate() failed (error code "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1760  					"%i).", vi->i_ino,
98b270362bb9ea Anton Altaparmakov  2005-10-11  1761  					(unsigned)le32_to_cpu(ni->type), err);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1762  			return err;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1763  		}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1764  	}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1765  	/*
98b270362bb9ea Anton Altaparmakov  2005-10-11  1766  	 * Determine the number of pages per cluster for non-resident
98b270362bb9ea Anton Altaparmakov  2005-10-11  1767  	 * attributes.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1768  	 */
98b270362bb9ea Anton Altaparmakov  2005-10-11  1769  	nr_pages = 1;
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1770  	if (vol->cluster_size > PAGE_SIZE && NInoNonResident(ni))
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1771  		nr_pages = vol->cluster_size >> PAGE_SHIFT;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1772  	last_vcn = -1;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1773  	do {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1774  		VCN vcn;
69bc169ec33f10 Colin Ian King      2022-05-17  1775  		pgoff_t start_idx;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1776  		unsigned ofs, do_pages, u;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1777  		size_t copied;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1778  
69bc169ec33f10 Colin Ian King      2022-05-17  1779  		start_idx = pos >> PAGE_SHIFT;
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1780  		ofs = pos & ~PAGE_MASK;
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1781  		bytes = PAGE_SIZE - ofs;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1782  		do_pages = 1;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1783  		if (nr_pages > 1) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1784  			vcn = pos >> vol->cluster_size_bits;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1785  			if (vcn != last_vcn) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1786  				last_vcn = vcn;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1787  				/*
98b270362bb9ea Anton Altaparmakov  2005-10-11  1788  				 * Get the lcn of the vcn the write is in.  If
98b270362bb9ea Anton Altaparmakov  2005-10-11  1789  				 * it is a hole, need to lock down all pages in
98b270362bb9ea Anton Altaparmakov  2005-10-11  1790  				 * the cluster.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1791  				 */
98b270362bb9ea Anton Altaparmakov  2005-10-11  1792  				down_read(&ni->runlist.lock);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1793  				lcn = ntfs_attr_vcn_to_lcn_nolock(ni, pos >>
c49c31115067bc Richard Knutsson    2006-09-30  1794  						vol->cluster_size_bits, false);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1795  				up_read(&ni->runlist.lock);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1796  				if (unlikely(lcn < LCN_HOLE)) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1797  					if (lcn == LCN_ENOMEM)
98b270362bb9ea Anton Altaparmakov  2005-10-11  1798  						status = -ENOMEM;
a632f559304130 Anton Altaparmakov  2015-03-11  1799  					else {
a632f559304130 Anton Altaparmakov  2015-03-11  1800  						status = -EIO;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1801  						ntfs_error(vol->sb, "Cannot "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1802  							"perform write to "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1803  							"inode 0x%lx, "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1804  							"attribute type 0x%x, "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1805  							"because the attribute "
98b270362bb9ea Anton Altaparmakov  2005-10-11  1806  							"is corrupt.",
98b270362bb9ea Anton Altaparmakov  2005-10-11  1807  							vi->i_ino, (unsigned)
98b270362bb9ea Anton Altaparmakov  2005-10-11  1808  							le32_to_cpu(ni->type));
a632f559304130 Anton Altaparmakov  2015-03-11  1809  					}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1810  					break;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1811  				}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1812  				if (lcn == LCN_HOLE) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1813  					start_idx = (pos & ~(s64)
98b270362bb9ea Anton Altaparmakov  2005-10-11  1814  							vol->cluster_size_mask)
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1815  							>> PAGE_SHIFT;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1816  					bytes = vol->cluster_size - (pos &
98b270362bb9ea Anton Altaparmakov  2005-10-11  1817  							vol->cluster_size_mask);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1818  					do_pages = nr_pages;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1819  				}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1820  			}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1821  		}
a632f559304130 Anton Altaparmakov  2015-03-11  1822  		if (bytes > iov_iter_count(i))
a632f559304130 Anton Altaparmakov  2015-03-11  1823  			bytes = iov_iter_count(i);
a632f559304130 Anton Altaparmakov  2015-03-11  1824  again:
98b270362bb9ea Anton Altaparmakov  2005-10-11  1825  		/*
98b270362bb9ea Anton Altaparmakov  2005-10-11  1826  		 * Bring in the user page(s) that we will copy from _first_.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1827  		 * Otherwise there is a nasty deadlock on copying from the same
98b270362bb9ea Anton Altaparmakov  2005-10-11  1828  		 * page(s) as we are writing to, without it/them being marked
98b270362bb9ea Anton Altaparmakov  2005-10-11  1829  		 * up-to-date.  Note, at present there is nothing to stop the
98b270362bb9ea Anton Altaparmakov  2005-10-11  1830  		 * pages being swapped out between us bringing them into memory
98b270362bb9ea Anton Altaparmakov  2005-10-11  1831  		 * and doing the actual copying.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1832  		 */
a6294593e8a129 Andreas Gruenbacher 2021-08-02  1833  		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
a632f559304130 Anton Altaparmakov  2015-03-11  1834  			status = -EFAULT;
a632f559304130 Anton Altaparmakov  2015-03-11  1835  			break;
a632f559304130 Anton Altaparmakov  2015-03-11  1836  		}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1837  		/* Get and lock @do_pages starting at index @start_idx. */
98b270362bb9ea Anton Altaparmakov  2005-10-11  1838  		status = __ntfs_grab_cache_pages(mapping, start_idx, do_pages,
4c99000ac47cbd Minchan Kim         2010-05-24  1839  				pages, &cached_page);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1840  		if (unlikely(status))
98b270362bb9ea Anton Altaparmakov  2005-10-11  1841  			break;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1842  		/*
98b270362bb9ea Anton Altaparmakov  2005-10-11  1843  		 * For non-resident attributes, we need to fill any holes with
98b270362bb9ea Anton Altaparmakov  2005-10-11  1844  		 * actual clusters and ensure all bufferes are mapped.  We also
98b270362bb9ea Anton Altaparmakov  2005-10-11  1845  		 * need to bring uptodate any buffers that are only partially
98b270362bb9ea Anton Altaparmakov  2005-10-11  1846  		 * being written to.
98b270362bb9ea Anton Altaparmakov  2005-10-11  1847  		 */
98b270362bb9ea Anton Altaparmakov  2005-10-11  1848  		if (NInoNonResident(ni)) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1849  			status = ntfs_prepare_pages_for_non_resident_write(
98b270362bb9ea Anton Altaparmakov  2005-10-11  1850  					pages, do_pages, pos, bytes);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1851  			if (unlikely(status)) {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1852  				do {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1853  					unlock_page(pages[--do_pages]);
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1854  					put_page(pages[do_pages]);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1855  				} while (do_pages);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1856  				break;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1857  			}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1858  		}
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1859  		u = (pos >> PAGE_SHIFT) - pages[0]->index;
a632f559304130 Anton Altaparmakov  2015-03-11  1860  		copied = ntfs_copy_from_user_iter(pages + u, do_pages - u, ofs,
a632f559304130 Anton Altaparmakov  2015-03-11  1861  					i, bytes);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1862  		ntfs_flush_dcache_pages(pages + u, do_pages - u);
a632f559304130 Anton Altaparmakov  2015-03-11  1863  		status = 0;
a632f559304130 Anton Altaparmakov  2015-03-11  1864  		if (likely(copied == bytes)) {
a632f559304130 Anton Altaparmakov  2015-03-11  1865  			status = ntfs_commit_pages_after_write(pages, do_pages,
a632f559304130 Anton Altaparmakov  2015-03-11  1866  					pos, bytes);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1867  		}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1868  		do {
98b270362bb9ea Anton Altaparmakov  2005-10-11  1869  			unlock_page(pages[--do_pages]);
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1870  			put_page(pages[do_pages]);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1871  		} while (do_pages);
9067931236651c Al Viro             2021-05-30  1872  		if (unlikely(status < 0)) {
9067931236651c Al Viro             2021-05-30  1873  			iov_iter_revert(i, copied);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1874  			break;
9067931236651c Al Viro             2021-05-30  1875  		}
98b270362bb9ea Anton Altaparmakov  2005-10-11  1876  		cond_resched();
9067931236651c Al Viro             2021-05-30  1877  		if (unlikely(copied < bytes)) {
9067931236651c Al Viro             2021-05-30  1878  			iov_iter_revert(i, copied);
9067931236651c Al Viro             2021-05-30  1879  			if (copied)
9067931236651c Al Viro             2021-05-30  1880  				bytes = copied;
9067931236651c Al Viro             2021-05-30  1881  			else if (bytes > PAGE_SIZE - ofs)
9067931236651c Al Viro             2021-05-30  1882  				bytes = PAGE_SIZE - ofs;
a632f559304130 Anton Altaparmakov  2015-03-11  1883  			goto again;
a632f559304130 Anton Altaparmakov  2015-03-11  1884  		}
a632f559304130 Anton Altaparmakov  2015-03-11  1885  		pos += copied;
a632f559304130 Anton Altaparmakov  2015-03-11  1886  		written += copied;
a632f559304130 Anton Altaparmakov  2015-03-11  1887  		balance_dirty_pages_ratelimited(mapping);
a632f559304130 Anton Altaparmakov  2015-03-11  1888  		if (fatal_signal_pending(current)) {
a632f559304130 Anton Altaparmakov  2015-03-11  1889  			status = -EINTR;
a632f559304130 Anton Altaparmakov  2015-03-11  1890  			break;
a632f559304130 Anton Altaparmakov  2015-03-11  1891  		}
a632f559304130 Anton Altaparmakov  2015-03-11  1892  	} while (iov_iter_count(i));
98b270362bb9ea Anton Altaparmakov  2005-10-11  1893  	if (cached_page)
09cbfeaf1a5a67 Kirill A. Shutemov  2016-04-01  1894  		put_page(cached_page);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1895  	ntfs_debug("Done.  Returning %s (written 0x%lx, status %li).",
98b270362bb9ea Anton Altaparmakov  2005-10-11  1896  			written ? "written" : "status", (unsigned long)written,
98b270362bb9ea Anton Altaparmakov  2005-10-11  1897  			(long)status);
98b270362bb9ea Anton Altaparmakov  2005-10-11  1898  	return written ? written : status;
98b270362bb9ea Anton Altaparmakov  2005-10-11  1899  }
98b270362bb9ea Anton Altaparmakov  2005-10-11  1900  

:::::: The code at line 1725 was first introduced by commit
:::::: a632f5593041305c8adbf4727bc1ccdf0b45178b NTFS: Version 2.1.32 - Update file write from aio_write to write_iter.

:::::: TO: Anton Altaparmakov <anton@tuxera.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
